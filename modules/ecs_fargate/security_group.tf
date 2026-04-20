resource "aws_security_group" "ecs" {
  name   = "${var.app_name}-${var.env}-ecs-sg"
  vpc_id = var.vpc_id

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-ecs-sg"
  })
}

resource "aws_security_group_rule" "ingress_alb" {
  type                     = "ingress"
  from_port                = var.target_port
  to_port                  = var.target_port
  protocol                 = var.sg_target_protocol
  security_group_id        = aws_security_group.ecs.id
  source_security_group_id = var.alb_sg_id
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs.id
}

resource "aws_security_group_rule" "ingress_endpoint" {
  count = var.is_endpoint && var.endpoint_sg_id != null ? 1 : 0

  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs.id

  # This is ignored when count=0, but a dummy process is necessary to pass validation
  source_security_group_id = var.endpoint_sg_id
}