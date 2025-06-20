variable "sns_topic_name" {
  description = "Name of SNS topic for alerts"
  type        = string
}

variable "notification_email" {
  description = "Email address to receive alerts"
  type        = string
}

variable "ec2_asg_name" {
  description = "Name of the EC2 Auto Scaling Group"
  type        = string
}
