locals {
  dbcreds = {
    password = random_password.master_password.result
  }
}

resource "aws_secretsmanager_secret" "sm" {
  name = "${var.app_name}-rds-secret"
  tags = local.common_tags #tfsec:ignore:AWS095
}

resource "aws_secretsmanager_secret_version" "sm_ver" {
  secret_id     = aws_secretsmanager_secret.sm.id
  secret_string = jsonencode(local.dbcreds)
}

resource "random_password" "master_password" {
  length      = 16
  special     = true
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  lifecycle {
    ignore_changes = all
  }
}
