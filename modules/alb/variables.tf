variable "vpc_id" {
    description = "VPC ID where the ALB will be deployed."
    type        = string  
  
}

variable "subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "target_group_arns" {
  description = "List of target group ARNs to attach to the ALB"
  type        = list(string)
  default     = []
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "app-load-balancer"
}

variable "alb_security_group_ids" {
  description = "List of security groups to attach to the ALB"
  type        = list(string)
}
