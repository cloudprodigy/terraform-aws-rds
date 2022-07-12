variable "app_name" {
  description = "Application Name"
  type        = string

}

variable "environment" {
  description = "The environment where database will be deployed"
  type        = string
}

variable "kms_key_id" {
  description = "RDS Encryption key"
  type        = string
  default     = ""
}

variable "enable_encryption" {
  description = "Whether or not to enable database encryption"
  type        = bool
  default     = true
}
variable "ingress_security_group_ids" {
  description = "Allowed Security Groups for RDS incoming traffic"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "private_subnets" {
  type        = list(string)
  default     = []
  description = "List of subnet IDs to use."
}

variable "replica_count" {
  type        = number
  default     = 1
  description = "Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead."
}

variable "instance_type" {
  type        = string
  default     = "db.t3.medium"
  description = "Instance type to use."
}

variable "database_name" {
  type        = string
  default     = ""
  description = "Name for an automatically created database on cluster creation."
}

variable "port" {
  type        = string
  default     = ""
  description = "Database port."
}
variable "username" {
  type        = string
  default     = ""
  description = "Master DB username."
}

variable "final_snapshot_identifier_prefix" {
  type        = string
  default     = "final"
  description = "The prefix name to use when creating a final snapshot on cluster destroy."
}

variable "skip_final_snapshot" {
  type        = bool
  default     = false
  description = "Should a final snapshot be created on cluster destroy."
}

variable "deletion_protection" {
  type        = bool
  default     = false
  description = "If the DB instance should have deletion protection enabled."
}

variable "backup_retention_period" {
  type        = number
  default     = 14
  description = "How long to keep backups for (in days)."
}

variable "preferred_backup_window" {
  type        = string
  default     = "22:00-02:00"
  description = "When to perform DB backups."
}

variable "preferred_maintenance_window" {
  type        = string
  default     = "sun:05:00-sun:06:00"
  description = "When to perform DB maintenance."
}

variable "apply_immediately" {
  type        = bool
  default     = false
  description = "Determines whether or not any DB modifications are applied immediately, or during the maintenance window."
}

variable "monitoring_interval" {
  type        = string
  default     = "5"
  description = "The interval (seconds) between points when Enhanced Monitoring metrics are collected."
}

variable "snapshot_identifier" {
  type        = string
  default     = ""
  description = "DB snapshot to create this database from."
}

variable "engine" {
  type        = string
  default     = "mysql"
  description = "Database engine type. Valid values are: aurora | aurora-mysql | aurora-postgresql | mysql | mariadb | postgresql"
}

variable "engine_version" {
  type        = string
  default     = "5.7"
  description = "Database engine version. Valid values are: 5.7 | 5.7.mysql_aurora.2.09.1"
}

variable "engine_mode" {
  description = "Engine mode to be used for cluster. Valid values are `provisioned` and `multimaster`."
  default     = "provisioned"
  type        = string
}
variable "replica_scale_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable autoscaling for RDS Aurora (MySQL) read replicas."
}

variable "replica_scale_max" {
  type        = number
  default     = 0
  description = "Maximum number of replicas to allow scaling."
}

variable "replica_scale_min" {
  type        = number
  default     = 2
  description = "Minimum number of replicas to allow scaling."
}

variable "predefined_metric_type" {
  description = "Metric Type for RDS Replica Auto Scaling"
  default     = "RDSReaderAverageCPUUtilization"
  type        = string

}

variable "replica_scale_connections" {
  description = "Average number of connections to trigger autoscaling at. Default value is 70% of db.r4.large's default max_connections"
  type        = number
  default     = 700
}

variable "replica_scale_cpu" {
  type        = number
  default     = 80
  description = "CPU usage to trigger autoscaling."
}

variable "replica_scale_in_cooldown" {
  type        = number
  default     = 300
  description = "Cooldown in seconds before allowing further scaling operations after a scale in."
}

variable "replica_scale_out_cooldown" {
  type        = number
  default     = 300
  description = "Cooldown in seconds before allowing further scaling operations after a scale out."
}

variable "performance_insights_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether Performance Insights is enabled or not."
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  default     = ["audit", "error", "slowquery"]
  description = "List of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: audit, error, general, slowquery, postgresql (PostgreSQL)."
}

variable "db_parameters" {
  type        = list(map(string))
  description = "List of custom parameters for parameter group"
  default     = []

}

variable "db_family" {
  type        = string
  default     = "mysql5.7" //sqlserver-ex-15.0
  description = "The family of the DB parameter group."
}

variable "db_options" {
  type        = any
  default     = []
  description = "DB Options"
}

variable "major_engine_version" {
  type        = string
  default     = ""
  description = "Major engine version for options group"
}

variable "option_group_name" {
  type        = string
  default     = ""
  description = "DB option group name"
}

variable "storage" {
  type        = number
  description = "Storage in GB for non-aurora database engines"
  default     = null

}

variable "max_allocated_storage" {
  type        = number
  description = "Set it to higher than storage to enable autoscaling"
  default     = null
}

variable "storage_type" {
  type        = string
  description = "Storage type for non-aurora database engines (gp2|iops)"
  default     = ""
}
variable "iops" {
  type        = string
  description = "The amount of provisioned IOPS, if `storage_type` is `iops`"
  default     = ""
}

variable "is_multi_az" {
  type        = bool
  description = "Whether RDS will be deployed into Multi-AZ or not"
  default     = false
}


locals {
  common_tags = {
    environment = var.environment
  }

}

