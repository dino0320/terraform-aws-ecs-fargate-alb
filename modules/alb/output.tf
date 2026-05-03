output "alb_dns_name" {
  value       = aws_lb.this.dns_name
  description = "The DNS name of the load balancer"
}

output "target_group_arn" {
  value = aws_lb_target_group.this.arn
  description = "The ARN of the Target Group"
}

output "alb_sg_id" {
  value = aws_security_group.alb.id
  description = "The Security Group ID assigned to the ALB"
}