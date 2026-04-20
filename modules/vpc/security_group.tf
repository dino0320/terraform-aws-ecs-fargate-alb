resource "aws_security_group" "vpc_endpoint" {
  name   = "${var.app_name}-${var.env}-endpoint-sg"
  vpc_id = aws_vpc.this.id

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-endpoint-sg"
  })
}

resource "aws_security_group_rule" "ingress_app" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.vpc_endpoint.id
  source_security_group_id = var.app_sg_id
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpc_endpoint.id
}