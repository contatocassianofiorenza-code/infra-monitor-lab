terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  aws_region   = var.aws_region
}

module "ec2" {
  source           = "./modules/ec2"
  project_name     = var.project_name
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.vpc.subnet_id
  allowed_ssh_cidr = var.allowed_ssh_cidr
  ami_id           = var.ami_id
}
