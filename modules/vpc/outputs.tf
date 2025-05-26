output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private[*].id
}


# output "default_security_group_id" {
#   value = aws_vpc.this.default_security_group_id
# }
output "default_security_group_id" {
  description = "Default security group ID for the VPC"
  value       = aws_vpc.this.default_security_group_id
}
