resource "aws_db_subnet_group" "this" {
  name       = "${var.app_name}-${var.env}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-db-subnet-group"
  })
}

resource "random_password" "db_password" {
  length  = var.password_length
  special = var.is_special
}

resource "aws_secretsmanager_secret" "db_password" {
  name = "${var.app_name}-${var.env}-db-password"
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = random_password.db_password.result
}

resource "aws_db_instance" "this" {
  identifier = "${var.app_name}-${var.env}-db"

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type

  db_name  = var.db_name
  username = var.db_username
  password = random_password.db_password.result

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db.id]

  publicly_accessible = false
  skip_final_snapshot = var.is_skip_final_snapshot
  deletion_protection = var.is_deletion_protection

  lifecycle {
    ignore_changes = [password] # Avoid instance replacement on password updates
  }

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-db"
  })
}