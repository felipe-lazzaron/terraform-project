variable "aws_ami" {
  type        = string
  description = "AWS AMI"
  default     = "ami-0fc5d935ebf8bc3bc"
}

variable "aws_instance_type" {
  type        = string
  description = "AWS Instance Type"
  default     = "t2.micro"
}

variable "instance_tags" {
  type        = map(string)
  description = "Instance Tags"
  default = {
    Name    = "HelloWorld"
    Project = "Terraform Course"
  }
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "ec2_security_group_id" {
  type        = string
  description = "Security Group ID"

}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs"
}

variable "security_groups" {
  type        = list(string)
  description = "Security Groups"
}

variable "rds_host" {
  type        = string
  description = "RDS Host"
}