resource "aws_security_group" "alb" {
  name   = "${var.app_name}-${var.env}-alb-sg"
  vpc_id = var.vpc_id

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-alb-sg"
  })
}

resource "aws_security_group_rule" "ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "egress_target" {
  type                     = "egress"
  from_port                = var.target_port
  to_port                  = var.target_port
  protocol                 = var.sg_target_protocol
  security_group_id        = aws_security_group.alb.id
  source_security_group_id = var.app_sg_id
}

resource "aws_security_group_rule" "ingress_http" {
  count = var.is_http ? 1 : 0

  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}