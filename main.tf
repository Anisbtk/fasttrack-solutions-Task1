# VPC Setup
module "vpc" {
  source = "./modules/vpc"
}

# Compute and Networking Setup
module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
}

# Database Setup
module "rds" {
  source = "./modules/rds"
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}

# Storage Setup
module "s3" {
  source = "./modules/s3"
}

# IAM Roles and Policies Setup
module "iam" {
  source = "./modules/iam"
}
