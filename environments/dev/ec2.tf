module "ec2_autoscaling" {
  source = "../../modules/ec2-autoscaling"

  ami_id                  = var.ami_id
  instance_type           = var.instance_type
  asg_min_size            = var.asg_min_size
  asg_max_size            = var.asg_max_size
  asg_desired_capacity    = var.asg_desired_capacity
  vpc_id                  = module.vpc.vpc_id
  vpc_security_group_ids  = []
  subnet_ids              = module.vpc.public_subnet_ids

  alb_target_group_arn    = module.alb.target_group_arn
}
