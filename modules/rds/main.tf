resource "aws_db_parameter_group" "my_db_parameter_group" {
  name        = "my-db-parameter-group"
  family      = "mysql8.0"
  description = "My DB Parameter Group"

  parameter {
    name         = "max_connections"
    value        = "100"
    apply_method = "immediate"
  }

  parameter {
    name         = "innodb_buffer_pool_size"
    value        = "67108864" # 64 MB
    apply_method = "pending-reboot"
  }
}

resource "aws_db_instance" "my_rds" {
  identifier             = var.rds_identifier
  allocated_storage      = var.rds_allocated_storage
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  instance_class         = var.rds_instance_class
  db_name                = var.db_name
  username               = var.rds_username
  password               = var.rds_password
  port                   = var.rds_port
  parameter_group_name   = aws_db_parameter_group.my_db_parameter_group.name
  multi_az               = var.rds_multi_az
  storage_type           = var.rds_storage_type
  db_subnet_group_name   = var.subnet_name
  vpc_security_group_ids = [var.rds_security_group_id]
  publicly_accessible    = var.rds_publicly_accessible

  final_snapshot_identifier = "final-snapshot-${formatdate("YYYYMMDDHHmmss", timestamp())}"
  backup_retention_period   = var.backup_retention_period
  backup_window             = var.backup_window
  maintenance_window        = var.maintenance_window

  tags = var.rds_tags
}
