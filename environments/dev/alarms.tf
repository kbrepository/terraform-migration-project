module "cloudwatch_alarms" {
  source              = "../../modules/cloudwatch-alarms"
  sns_topic_name      = "infra-monitoring-topic"
  notification_email  = "your_email@example.com" # Replace with your email
  ec2_asg_name        = module.ec2_autoscaling.asg_name
}
