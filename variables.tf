variable "environment" {
  type        = string
  description = "Environment"
  // default     = "dev"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS Profile"
  default     = "tf-course" // mudar para felipe.lazzaron?
}