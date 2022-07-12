locals {
  option_group_name = var.option_group_name == "" ? "rds-${var.app_name}-${var.environment}-og" : var.option_group_name
  port              = var.port == "" ? var.engine == "aurora-postgresql" || var.engine == "postgresql" ? "5432" : "3306" : var.port
  identifier        = "${var.app_name}-${var.environment}"
  engine            = var.engine == "" ? "mysql" : var.engine
  kms_key_id        = var.enable_encryption ? var.kms_key_id == "" ? aws_kms_key.this[0].arn : var.kms_key_id : null
  engine_version    = var.engine_version == "" ? "5.7" : var.engine_version //15.00.4198.2.v1
}