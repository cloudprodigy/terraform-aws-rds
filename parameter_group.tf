resource "aws_db_parameter_group" "default" {
  name        = lower(var.app_name)
  family      = var.db_family
  description = format("Parameter group for %s", local.identifier)

  dynamic "parameter" {
    for_each = var.db_parameters

    content {
      name         = parameter.value["name"]
      value        = parameter.value["value"]
      apply_method = lookup(parameter.value, "apply_method", "immediate")
    }
  }

  tags = local.common_tags
}

resource "aws_rds_cluster_parameter_group" "default" {
  count  = local.engine == "aurora-postgresql" || local.engine == "aurora-mysql" ? 1 : 0
  name   = lower(var.app_name)
  family = var.db_family

  dynamic "parameter" {
    for_each = var.cluster_db_parameters

    content {
      name         = parameter.value["name"]
      value        = parameter.value["value"]
      apply_method = lookup(parameter.value, "apply_method", "immediate")
    }
  }
  tags = local.common_tags
}