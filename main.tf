provider "aws" {
  region     = "us-east-2"
  access_key = var.access-key
  secret_key = var.secret-key 
}

module "vpc" {
    source = "./modules/vpc"
}