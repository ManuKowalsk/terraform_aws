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
    security_group_db_id = module.security_groups.db_security_group_id
    subnet_private1_id = module.vpc.subnet_private1_id
    subnet_private2_id = module.vpc.subnet_private2_id
}

module "security_groups" {
    source = "./modules/security_groups"
    vpc_ipv6_cidr_block = module.vpc.vpc_ipv6_cidr_block
    vpc_cidr_block = module.vpc.vpc_cidr_block
    vpc_id = module.vpc.vpc_id
}

module "ec2" {
    source ="./modules/ec2"
    parameters = [
        {
            name = "EC2_1"
            SubId = module.vpc.subnet_private1_id
        },
        {
            name = "EC1_2"
            SubId = module.vpc.subnet_private2_id
        }
    ]
    ec2_security_group_id = module.security_groups.ec2_security_group_id
    db_name= module.rds.db_name
    db_username= module.rds.db_username
    db_password= module.rds.db_password
    db_endpoint= module.rds.db_endpoint
}

module "load_balancer"{
    source = "./modules/load_balancer"
    subnet_id_list = [module.vpc.subnet_public1_id,module.vpc.subnet_public2_id]
    loadbalancer_security_group = module.security_groups.loadbalancer_security_group_id
    vpc_id = module.vpc.vpc_id
    instances_id = module.ec2.aws_instance
}