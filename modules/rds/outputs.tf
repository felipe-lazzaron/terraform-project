output "rds_endpoint" {
  value = aws_db_instance.my_rds.endpoint
}

output "rds_host" {
  value = aws_db_instance.my_rds.address
}