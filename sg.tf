resource "aws_security_group" "rds" {
  name        = "${var.app_name}_rds_sg"
  description = "Security Group for RDS Instance or Cluster"
  vpc_id      = var.vpc_id

  tags = local.common_tags

  ingress {
    from_port       = local.port
    to_port         = local.port
    protocol        = "tcp"
    security_groups = var.ingress_security_group_ids
  }
  ingress {
    from_port   = local.port
    to_port     = local.port
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
}
