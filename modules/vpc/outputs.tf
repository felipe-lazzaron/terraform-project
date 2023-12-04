output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_id" {
  value = aws_subnet.my_subnet[0].id
}

output "subnet_names" {
  value = [for subnet in aws_subnet.my_subnet : subnet.tags["Name"]]
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.my_db_subnet_group.name
}

output "subnet_id_1" {
  value = aws_subnet.my_subnet[0].id
}

output "subnet_id_2" {
  value = aws_subnet.my_subnet[1].id
}


