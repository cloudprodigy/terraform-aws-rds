# Custom DB options created for SQL Server engine if `option_group_name` variable is empty.
resource "aws_db_option_group" "this" {
  count = local.engine == "sqlserver-se" || local.engine == "sqlserver-ex" && var.option_group_name == "" ? 1 : 0

  name                     = local.option_group_name
  option_group_description = "DB options group for ${local.engine}"
  engine_name              = local.engine
  major_engine_version     = var.major_engine_version

  dynamic "option" {
    for_each = var.db_options
    content {
      option_name                    = option.value.option_name
      port                           = lookup(option.value, "port", null)
      version                        = lookup(option.value, "version", null)
      db_security_group_memberships  = lookup(option.value, "db_security_group_memberships", null)
      vpc_security_group_memberships = lookup(option.value, "vpc_security_group_memberships", null)

      dynamic "option_settings" {
        for_each = lookup(option.value, "option_settings", [])
        content {
          name  = lookup(option_settings.value, "name", null)
          value = lookup(option_settings.value, "value", null)
        }
      }
    }
  }

  tags = local.common_tags

}
