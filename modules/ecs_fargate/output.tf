output "ecs_sg_id" {
  value = aws_security_group.ecs.id
  description = "The Security Group ID assigned to the ECS service"
}