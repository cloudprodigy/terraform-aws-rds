# RDS Module

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.52.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.autoscaling_read_replica_count](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.read_replica_count](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_db_instance.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_iam_role.rds_enhanced_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.rds_enhanced_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_rds_cluster.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_rds_cluster_parameter_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_secretsmanager_secret.sm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.sm_ver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_id.master_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.snapshot_identifier](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_iam_policy_document.monitoring_rds_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Application Name | `string` | n/a | yes |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Determines whether or not any DB modifications are applied immediately, or during the maintenance window. | `bool` | `false` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | How long to keep backups for (in days). | `number` | `14` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name for an automatically created database on cluster creation. | `string` | `""` | no |
| <a name="input_db_family"></a> [db\_family](#input\_db\_family) | The family of the DB parameter group. | `string` | `"mysql5.7"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | If the DB instance should have deletion protection enabled. | `bool` | `false` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | List of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: audit, error, general, slowquery, postgresql (PostgreSQL). | `list(string)` | <pre>[<br>  "audit",<br>  "error",<br>  "slowquery"<br>]</pre> | no |
| <a name="input_engine"></a> [engine](#input\_engine) | Database engine type. Valid values are: aurora \| aurora-mysql \| aurora-postgresql \| mysql \| mariadb \| postgresql | `string` | `"mysql"` | no |
| <a name="input_engine_mode"></a> [engine\_mode](#input\_engine\_mode) | Engine mode to be used for cluster. Valid values are `provisioned` and `multimaster`. | `string` | `"provisioned"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Database engine version. Valid values are: 5.7 \| 5.7.mysql\_aurora.2.09.1 | `string` | `"5.7"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment where database will be deployed | `string` | n/a | yes |
| <a name="input_final_snapshot_identifier_prefix"></a> [final\_snapshot\_identifier\_prefix](#input\_final\_snapshot\_identifier\_prefix) | The prefix name to use when creating a final snapshot on cluster destroy. | `string` | `"final"` | no |
| <a name="input_ingress_security_group_ids"></a> [ingress\_security\_group\_ids](#input\_ingress\_security\_group\_ids) | Allowed Security Groups for RDS incoming traffic | `list(string)` | `[]` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to use. | `string` | `"db.t3.medium"` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | The amount of provisioned IOPS, if `storage_type` is `iops` | `string` | `""` | no |
| <a name="input_is_multi_az"></a> [is\_multi\_az](#input\_is\_multi\_az) | Whether RDS will be deployed into Multi-AZ or not | `bool` | `true` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | RDS Encryption key | `string` | n/a | yes |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval (seconds) between points when Enhanced Monitoring metrics are collected. | `string` | `"5"` | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | Specifies whether Performance Insights is enabled or not. | `bool` | `false` | no |
| <a name="input_port"></a> [port](#input\_port) | Database port. | `string` | `""` | no |
| <a name="input_predefined_metric_type"></a> [predefined\_metric\_type](#input\_predefined\_metric\_type) | Metric Type for RDS Replica Auto Scaling | `string` | `"RDSReaderAverageCPUUtilization"` | no |
| <a name="input_preferred_backup_window"></a> [preferred\_backup\_window](#input\_preferred\_backup\_window) | When to perform DB backups. | `string` | `"22:00-02:00"` | no |
| <a name="input_preferred_maintenance_window"></a> [preferred\_maintenance\_window](#input\_preferred\_maintenance\_window) | When to perform DB maintenance. | `string` | `"sun:05:00-sun:06:00"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of subnet IDs to use. | `list(string)` | `[]` | no |
| <a name="input_replica_count"></a> [replica\_count](#input\_replica\_count) | Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead. | `number` | `1` | no |
| <a name="input_replica_scale_connections"></a> [replica\_scale\_connections](#input\_replica\_scale\_connections) | Average number of connections to trigger autoscaling at. Default value is 70% of db.r4.large's default max\_connections | `number` | `700` | no |
| <a name="input_replica_scale_cpu"></a> [replica\_scale\_cpu](#input\_replica\_scale\_cpu) | CPU usage to trigger autoscaling. | `number` | `80` | no |
| <a name="input_replica_scale_enabled"></a> [replica\_scale\_enabled](#input\_replica\_scale\_enabled) | Whether to enable autoscaling for RDS Aurora (MySQL) read replicas. | `bool` | `false` | no |
| <a name="input_replica_scale_in_cooldown"></a> [replica\_scale\_in\_cooldown](#input\_replica\_scale\_in\_cooldown) | Cooldown in seconds before allowing further scaling operations after a scale in. | `number` | `300` | no |
| <a name="input_replica_scale_max"></a> [replica\_scale\_max](#input\_replica\_scale\_max) | Maximum number of replicas to allow scaling. | `number` | `0` | no |
| <a name="input_replica_scale_min"></a> [replica\_scale\_min](#input\_replica\_scale\_min) | Minimum number of replicas to allow scaling. | `number` | `2` | no |
| <a name="input_replica_scale_out_cooldown"></a> [replica\_scale\_out\_cooldown](#input\_replica\_scale\_out\_cooldown) | Cooldown in seconds before allowing further scaling operations after a scale out. | `number` | `300` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Should a final snapshot be created on cluster destroy. | `bool` | `false` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | DB snapshot to create this database from. | `string` | `""` | no |
| <a name="input_storage"></a> [storage](#input\_storage) | Storage in GB for non-aurora database engines | `string` | `""` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | Storage type for non-aurora database engines (gp2\|iops) | `string` | `""` | no |
| <a name="input_username"></a> [username](#input\_username) | Master DB username. | `string` | `""` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR Block | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rds_cluster_endpoint"></a> [rds\_cluster\_endpoint](#output\_rds\_cluster\_endpoint) | RDS Cluster Endpoint |
| <a name="output_rds_cluster_port"></a> [rds\_cluster\_port](#output\_rds\_cluster\_port) | Database Port for Aurora Cluster |
| <a name="output_rds_instance_endpoint"></a> [rds\_instance\_endpoint](#output\_rds\_instance\_endpoint) | RDS Database Instance Endpoint |
| <a name="output_rds_instance_port"></a> [rds\_instance\_port](#output\_rds\_instance\_port) | Database Port for single instance |
| <a name="output_rds_username"></a> [rds\_username](#output\_rds\_username) | Database username |
| <a name="output_secrets_manager_id"></a> [secrets\_manager\_id](#output\_secrets\_manager\_id) | ID of AWS SecretsManager used to store DB password. Valid key to retrieve password value is `password` |
