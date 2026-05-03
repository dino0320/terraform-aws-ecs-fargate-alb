output "vpc_id" {
  value = aws_vpc.this.id
  description = "The ID of the VPC"
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
  description = "List of private subnet IDs"
}

output "endpoint_sg_id" {
  value = aws_security_group.vpc_endpoint.id
  description = "The Security Group ID assigned to the VPC endpoints"
}