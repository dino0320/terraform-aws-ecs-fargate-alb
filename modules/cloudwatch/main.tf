resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${var.app_name}-${var.env}-${var.log_group_name}"
  retention_in_days = var.log_retention_days

  tags = merge(var.common_tags, {
    Name = "/ecs/${var.app_name}-${var.env}-${var.log_group_name}"
  })
}