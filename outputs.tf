output "rds_cluster_endpoint" {
  value       = aws_rds_cluster.default.*.endpoint
  description = "RDS Cluster Endpoint"
}

output "rds_instance_endpoint" {
  value       = aws_db_instance.default.*.endpoint
  description = "RDS Database Instance Endpoint"
}

output "rds_cluster_port" {
  value       = aws_rds_cluster.default.*.port
  description = "Database Port for Aurora Cluster"
}

output "rds_instance_port" {
  value       = aws_db_instance.default.*.port
  description = "Database Port for single instance"
}

output "secrets_manager_id" {
  value       = aws_secretsmanager_secret.sm.id
  description = "ID of AWS SecretsManager used to store DB password. Valid key to retrieve password value is `password`"
}

output "rds_username" {
  description = "Database username"
  value       = var.username
}
