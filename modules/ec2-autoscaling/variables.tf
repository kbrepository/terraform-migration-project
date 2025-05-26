variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "asg_min_size" {
  description = "Minimum number of instances in Auto Scaling Group"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum number of instances in Auto Scaling Group"
  type        = number
  default     = 2
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in Auto Scaling Group"
  type        = number
  default     = 1
}

variable "vpc_security_group_ids" {
  description = "List of Security Group IDs to attach to EC2 instances"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of Subnet IDs for launching EC2 instances"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC where EC2 will launch"
  type        = string
}

variable "alb_target_group_arn" {
  description = "Optional ALB target group to attach ASG to"
  type        = string
  default     = null
}