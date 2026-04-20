# ECS task execution role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.app_name}-${var.env}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
    }]
  })

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-ecs-task-execution-role"
  })
}

resource "aws_iam_role_policy_attachment" "execution_role_standard" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "cloud_watch_logs_policy" {
  count = var.is_cloud_watch_logs ? 1 : 0
  name  = "cloud_watch_logs_policy"
  role  = aws_iam_role.ecs_task_execution_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action   = "logs:CreateLogGroup"
      Effect   = "Allow"
      Resource = "arn:aws:logs:${var.region}:${var.account_id}:log-group:${var.app_name}-${var.env}-*"
    }]
  })
}

resource "aws_iam_role_policy" "secrets_manager_policy" {
  count = var.is_secrets_manager ? 1 : 0
  name  = "secrets_manager_policy"
  role  = aws_iam_role.ecs_task_execution_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action   = "secretsmanager:GetSecretValue"
      Effect   = "Allow"
      Resource = "arn:aws:secretsmanager:${var.region}:${var.account_id}:secret:${var.app_name}-${var.env}-*"
    }]
  })
}

# ECS task role
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.app_name}-${var.env}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
    }]
  })

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-ecs-task-role"
  })
}

resource "aws_iam_role_policy" "custom_task_policy" {
  count  = var.custom_task_role_policy == null ? 0 : 1
  name   = "${var.app_name}-${var.env}-custom-task-policy"
  role   = aws_iam_role.ecs_task_role.id
  policy = var.custom_task_role_policy
}