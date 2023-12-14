provider "aws" {
  region     = "us-east-2"
  access_key = var.access-key
  secret_key = var.secret-key 
}

module "vpc" {
    source = "./modules/vpc"
}

module "rds" {
    source = "./modules/rds"
}

module "security_groups" {
    source = "./modules/security_groups"
    vpc_ipv6_cidr_block = module.vpc.vpc_ipv6_cidr_block
    vpc_cidr_block = module.vpc.vpc_cidr_block
}