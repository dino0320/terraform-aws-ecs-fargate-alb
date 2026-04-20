resource "aws_security_group" "db" {
  name   = "${var.app_name}-${var.env}-db-sg"
  vpc_id = var.vpc_id

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-db-sg"
  })
}

resource "aws_security_group_rule" "ingress_app" {
  type                     = "ingress"
  from_port                = var.db_port
  to_port                  = var.db_port
  protocol                 = var.sg_db_protocol
  security_group_id        = aws_security_group.db.id
  source_security_group_id = var.app_sg_id
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.db.id
}