module "alb" {
  source     = "../../modules/alb"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet_ids
  alb_name   = "my-app-alb"
}