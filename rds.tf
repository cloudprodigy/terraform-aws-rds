resource "aws_db_subnet_group" "default" {
  name        = lower(var.app_name)
  description = format("For Database %s", local.identifier)
  subnet_ids  = var.private_subnets

  tags = local.common_tags
}

resource "random_id" "snapshot_identifier" {
  keepers = {
    id = var.app_name
  }

  byte_length = 4
}

resource "aws_rds_cluster" "default" {
  count                           = local.engine == "aurora-mysql" || local.engine == "aurora-postgresql" ? 1 : 0
  cluster_identifier              = local.identifier
  engine                          = local.engine
  engine_version                  = local.engine_version
  engine_mode                     = var.engine_mode
  kms_key_id                      = local.kms_key_id
  database_name                   = var.database_name
  master_username                 = var.username
  master_password                 = jsondecode(aws_secretsmanager_secret_version.sm_ver.secret_string)["password"]
  final_snapshot_identifier       = format("%s-%s", var.final_snapshot_identifier_prefix, local.identifier)
  skip_final_snapshot             = var.skip_final_snapshot
  deletion_protection             = var.deletion_protection
  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window
  port                            = local.port
  db_subnet_group_name            = aws_db_subnet_group.default.name
  vpc_security_group_ids          = [aws_security_group.rds.id]
  snapshot_identifier             = var.snapshot_identifier
  storage_encrypted               = true
  apply_immediately               = var.apply_immediately
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.default[0].id

  tags = local.common_tags
}


resource "aws_rds_cluster_instance" "default" {
  count = (local.engine == "aurora-mysql" || local.engine == "aurora-postgresql") ? (var.replica_scale_enabled ? var.replica_scale_min : var.replica_count) : 0

  identifier                   = format("%s-%s", local.identifier, (count.index + 1))
  cluster_identifier           = element(aws_rds_cluster.default.*.id, count.index)
  engine                       = local.engine
  engine_version               = local.engine_version
  instance_class               = var.instance_type
  publicly_accessible          = false
  db_subnet_group_name         = aws_db_subnet_group.default.name
  db_parameter_group_name      = aws_db_parameter_group.default.id
  preferred_maintenance_window = var.preferred_maintenance_window
  apply_immediately            = var.apply_immediately
  monitoring_interval          = var.monitoring_interval != null ? var.monitoring_interval : 0
  monitoring_role_arn          = var.monitoring_interval != null ? concat(aws_iam_role.rds_enhanced_monitoring.*.arn, [""])[0] : null
  auto_minor_version_upgrade   = false
  performance_insights_enabled = var.performance_insights_enabled


  tags = local.common_tags

}

resource "aws_db_instance" "default" {
  count = local.engine == "sqlserver-ex" || local.engine == "sqlserver-se" || local.engine == "mariadb" || local.engine == "postgres" || local.engine == "mysql" ? 1 : 0

  db_name                    = local.engine == "sqlserver-se" || local.engine == "sqlserver-ex" ? null : var.database_name
  engine                     = local.engine
  engine_version             = local.engine_version
  auto_minor_version_upgrade = false
  instance_class             = var.instance_type
  identifier                 = local.identifier
  vpc_security_group_ids     = [aws_security_group.rds.id]
  username                   = var.username
  password                   = jsondecode(aws_secretsmanager_secret_version.sm_ver.secret_string)["password"]
  port                       = local.port
  allocated_storage          = var.storage
  max_allocated_storage      = local.engine == "sqlserver-se" || local.engine == "sqlserver-ex" ? var.max_allocated_storage == null ? 0 : var.max_allocated_storage : null
  publicly_accessible        = false
  apply_immediately          = var.apply_immediately

  character_set_name = local.engine == "sqlserver-se" || local.engine == "sqlserver-ex" ? "SQL_Latin1_General_CP1_CI_AS" : null
  license_model      = local.engine == "sqlserver-se" || local.engine == "sqlserver-ex" ? "license-included" : null

  parameter_group_name = aws_db_parameter_group.default.id
  db_subnet_group_name = aws_db_subnet_group.default.name
  option_group_name    = local.engine == "sqlserver-se" || local.engine == "sqlserver-ex" ? var.option_group_name == "" ? concat(aws_db_option_group.this.*.id, [""])[0] : var.option_group_name : null

  multi_az                     = var.is_multi_az
  backup_retention_period      = var.backup_retention_period
  monitoring_interval          = var.monitoring_interval != null ? var.monitoring_interval : 0
  monitoring_role_arn          = var.monitoring_interval > 0 ? concat(aws_iam_role.rds_enhanced_monitoring.*.arn, [""])[0] : null
  storage_encrypted            = var.enable_encryption ? true : false
  kms_key_id                   = local.kms_key_id
  final_snapshot_identifier    = format("%s-%s-%s", var.final_snapshot_identifier_prefix, local.identifier, random_id.snapshot_identifier.hex)
  storage_type                 = var.storage_type
  iops                         = var.storage_type == "io1" ? var.iops == "" ? "3000" : var.iops : 0
  performance_insights_enabled = var.performance_insights_enabled
  skip_final_snapshot          = var.skip_final_snapshot
  copy_tags_to_snapshot        = true

  tags = local.common_tags
  lifecycle {
    ignore_changes = [
      password
    ]
  }
}

resource "aws_appautoscaling_target" "read_replica_count" {
  count = var.replica_scale_enabled ? 1 : 0

  max_capacity       = var.replica_scale_max
  min_capacity       = var.replica_scale_min
  resource_id        = "cluster:${aws_rds_cluster.default.*.cluster_identifier}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  service_namespace  = "rds"
}

resource "aws_appautoscaling_policy" "autoscaling_read_replica_count" {
  count = var.replica_scale_enabled ? 1 : 0

  name               = "${local.identifier}-target-metric"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "cluster:${aws_rds_cluster.default.*.cluster_identifier}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  service_namespace  = "rds"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type
    }

    scale_in_cooldown  = var.replica_scale_in_cooldown
    scale_out_cooldown = var.replica_scale_out_cooldown
    target_value       = var.predefined_metric_type == "RDSReaderAverageCPUUtilization" ? var.replica_scale_cpu : var.replica_scale_connections
  }

  depends_on = [aws_appautoscaling_target.read_replica_count]
}
