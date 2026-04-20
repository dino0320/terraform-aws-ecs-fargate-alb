resource "aws_ecs_cluster" "this" {
  name = "${var.app_name}-${var.env}-cluster"
  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-cluster"
  })
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.app_name}-${var.env}-fargate"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode(var.container_definitions)
}

resource "local_file" "task_definition" {
  filename = var.task_definition_file_path
  content  = jsonencode({
    family                  = "${var.app_name}-${var.env}-fargate"
    requiresCompatibilities = ["FARGATE"]
    networkMode             = "awsvpc"
    cpu                     = var.cpu
    memory                  = var.memory
    executionRoleArn        = aws_iam_role.ecs_task_execution_role.arn
    taskRoleArn             = aws_iam_role.ecs_task_role.arn
    containerDefinitions    = var.container_definitions
  })
}

resource "aws_ecs_service" "this" {
  name            = "${var.app_name}-${var.env}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.target_container
    container_port   = var.target_port
  }

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-service"
  })
}