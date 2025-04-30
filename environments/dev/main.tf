provider "aws" {
    region = "us-east-1"
}

# module "vpc" {
#   source                = "../../modules/vpc"
#   vpc_cidr              = var.vpc_cidr
#   public_subnet_cidrs   = var.public_subnet_cidrs
#   private_subnet_cidrs  = var.private_subnet_cidrs
#   azs                   = var.azs
# }

module "ec2_autoscaling" {
  source = "../../modules/ec2-autoscaling"
  ami_id = "ami-0c2b8ca1dad447f8a"
  instance_type = "t3.micro"
  asg_min_size = 1
  asg_max_size = 2
  asg_desired_capacity = 1
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_ids = module.vpc.public_subnet_ids
}