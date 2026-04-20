output "db_instance_address" {
  value       = aws_db_instance.this.address
  description = "The hostname of the RDS instance for database connections"
}

output "db_password_secret_arn" {
  value       = aws_secretsmanager_secret.db_password.arn
  description = "The ARN of the Secrets Manager secret containing the DB password"
}