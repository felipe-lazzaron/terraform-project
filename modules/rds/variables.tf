variable "rds_identifier" {
  type        = string
  description = "Identifier for the RDS instance"
  default     = "rds-identifier-value"
}

variable "rds_allocated_storage" {
  type        = number
  description = "Allocated storage for the RDS instance"
  default     = 10
}

variable "rds_engine" {
  type        = string
  description = "Database engine type for the RDS instance"
  default     = "mysql"
}

variable "rds_engine_version" {
  type        = string
  description = "Database engine version for the RDS instance"
  default     = "8.0"
}

variable "rds_instance_class" {
  type        = string
  description = "Instance class for the RDS instance"
  default     = "db.t2.micro"
}

variable "rds_username" {
  type        = string
  description = "Username for the RDS instance"
  default     = "rdsusernamevalue"
}

variable "rds_password" {
  type        = string
  description = "Password for the RDS instance"
  default     = "123123123123"
}

variable "rds_port" {
  type        = number
  description = "Port on which the RDS instance accepts connections"
  default     = 3306
}

variable "rds_parameter_group_name" {
  type        = string
  description = "Name of the parameter group for the RDS instance"
  default     = "rds-parameter-group-name-value"
}

variable "rds_publicly_accessible" {
  type        = bool
  description = "Whether the RDS instance is publicly accessible"
  default     = false
}

variable "rds_multi_az" {
  type        = bool
  description = "Whether the RDS instance is multi-AZ"
  default     = false
}

variable "rds_storage_type" {
  type        = string
  description = "Storage type for the RDS instance"
  default     = "gp2"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet group for the RDS instance"
}

variable "rds_tags" {
  type        = map(string)
  description = "Tags for the RDS instance"
  default     = {}
}

variable "db_name" {
  type        = string
  description = "Name of the database for the RDS instance"
  default     = "dbnamevalue" # Ajuste o nome conforme necessário
}


variable "backup_retention_period" {
  type        = number
  description = "Number of days to retain backups for the RDS instance"
  default     = 1
}

variable "backup_window" {
  type        = string
  description = "Backup window for the RDS instance"
  default     = "02:00-03:00"
}

variable "maintenance_window" {
  type        = string
  description = "Maintenance window for the RDS instance"
  default     = "Mon:03:00-Mon:03:30"
}

variable "rds_security_group_id" {
  type        = string
  description = "Security group ID for the RDS instance"
}