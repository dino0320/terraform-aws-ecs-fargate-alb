resource "aws_secretsmanager_secret" "app_secrets" {
  name = "${var.app_name}-${var.env}-${var.secrets_name}"

  recovery_window_in_days = var.recovery_window_in_days

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-${var.secrets_name}"
  })
}

resource "aws_secretsmanager_secret_version" "app_secrets_val" {
  secret_id     = aws_secretsmanager_secret.app_secrets.id
  secret_string = var.secret_values
}