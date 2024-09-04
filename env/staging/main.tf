module "vpc" {
  source = "../../modules/vpc"
}

module "ec2" {
  source = "../../modules/ec2"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  instance_type = "t3.micro"  
}

module "rds" {
  source = "../../modules/rds"
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  ec2_security_groups = [module.ec2.app_sg_id]  
}

module "s3" {
  source = "../../modules/s3"
}
