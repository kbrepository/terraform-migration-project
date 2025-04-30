output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = aws_launch_template.this.id
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.name
}

output "security_group_id" {
  description = "ID of the EC2 Security Group"
  value       = aws_security_group.this.id
}
