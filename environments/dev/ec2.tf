provider "aws" {
    region = "us-east-1"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket         = "your-tf-state-bucket"
    key            = "dev/vpc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}


module "ec2_autoscaling" {
  source = "../../modules/ec2-autoscaling"
  ami_id = "ami-0c2b8ca1dad447f8a"
  instance_type = "t3.micro"
  asg_min_size = 1
  asg_max_size = 2
  asg_desired_capacity = 1
  vpc_id                 = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids             = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.default_security_group_id]

}
