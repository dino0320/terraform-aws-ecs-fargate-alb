output "log_group_name" {
  value = aws_cloudwatch_log_group.this.name
  description = "The full name of the log group (including the project name and environment)"
}