resource "aws_lb" "this" {
  name               = "${var.app_name}-${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = var.env == "prod" ? true : false

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-alb"
  })
}

resource "aws_lb_target_group" "this" {
  name        = "${var.app_name}-${var.env}-tg"
  port        = var.target_port
  protocol    = var.target_protocol
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = var.health_check_path
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    interval            = var.interval
    matcher             = var.matcher
    port                = var.health_check_port
    protocol            = var.health_check_protocol
  }

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-tg"
  })

  lifecycle {
    create_before_destroy = true
  }
}

# The HTTPS listener is commented out until the certificate is ready
/*
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port = "443"
  protocol = "HTTPS"
  certificate_arn = var.certificate_arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
*/

resource "aws_lb_listener" "http" {
  count = var.is_http ? 1 : 0

  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}