terraform {
  required_version = "1.6.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.26.0"
    }
  }

  backend "s3" {
    bucket  = "lazzaron-bucket"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    #dynamodb_table = "lazzaron-lock-table-terraform"  # Nome exclusivo da tabela DynamoDB para o lock
  }


}

provider "aws" {
  region  = var.aws_region  // Região AWS
  profile = var.aws_profile // Perfil AWS para autenticação
}


module "sg" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source = "./modules/vpc"
}

module "rds" {
  source                = "./modules/rds"
  rds_security_group_id = module.sg.rds_security_group_id
  subnet_name           = module.vpc.db_subnet_group_name
}

module "lb" {
  source             = "./modules/lb"
  security_group_ids = [module.sg.lb_security_group_id]
  subnet_ids         = [module.vpc.subnet_id_1, module.vpc.subnet_id_2]
  vpc_id             = module.vpc.vpc_id
}

module "ec2" {
  source                = "./modules/ec2"
  ec2_security_group_id = module.sg.ec2_security_group_id
  subnet_id             = module.vpc.subnet_id
  subnet_ids            = [module.vpc.subnet_id_1, module.vpc.subnet_id_2]
  security_groups       = [module.sg.ec2_security_group_id]
  rds_host              = module.rds.rds_host
}
