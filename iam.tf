data "aws_iam_policy_document" "monitoring_rds_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "rds_enhanced_monitoring" {
  name               = "rds-enhanced-monitoring-${var.app_name}"
  assume_role_policy = data.aws_iam_policy_document.monitoring_rds_assume_role.json
  tags               = local.common_tags

}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  role       = join("", aws_iam_role.rds_enhanced_monitoring.*.name)
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}