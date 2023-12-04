variable "subnet_id" {
  type        = string
  description = "List of subnet IDs for the Application Load Balancer"
  default     = "subnet-0b455bd5f467e7a42" // Adicione IDs de sub-rede conforme necessário
}

// Adicione a nova CIDR block à lista existente
variable "subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] // Adicione a nova CIDR block aqui
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

output "subnet_ids" {
  value = aws_subnet.my_subnet[*].id
}