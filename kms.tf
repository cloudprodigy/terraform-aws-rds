# KMS key is created if encryption is enabled but external KMS key id is not provided.
resource "aws_kms_key" "this" {
  count                   = var.enable_encryption && var.kms_key_id == "" ? 1 : 0
  description             = "KMS key for ${local.identifier} database"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  tags                    = local.common_tags
}

resource "aws_kms_alias" "this" {
  count         = var.enable_encryption && var.kms_key_id == "" ? 1 : 0
  name          = "alias/rds-${local.identifier}-key"
  target_key_id = aws_kms_key.this[0].key_id
}