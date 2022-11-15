locals {
  dbcreds = {
    password = random_id.master_password.b64_url
  }
}

resource "aws_secretsmanager_secret" "sm" {
  #name = "${var.app_name}-rds-secret"
  name_prefix = var.app_name
  tags        = local.common_tags #tfsec:ignore:AWS095
}

resource "aws_secretsmanager_secret_version" "sm_ver" {
  secret_id     = aws_secretsmanager_secret.sm.id
  secret_string = jsonencode(local.dbcreds)
}

resource "random_id" "master_password" {
  byte_length = 20
  lifecycle {
    ignore_changes = all
  }
}
