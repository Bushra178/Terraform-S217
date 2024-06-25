resource "aws_lb" "app_lb" {
  name               = "wordpress-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_id
  subnets            = var.public_subnet_ids

  tags = {
    Name = "${var.env_prefix}-lb"
  }
}

resource "aws_lb_target_group" "lb-target-group" {
  name     = "wordpress-app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "${var.env_prefix}-lb-target-group"
  }
}

resource "aws_lb_listener" "lb-listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP" 

  default_action {
    target_group_arn = aws_lb_target_group.lb-target-group.arn
    type             = "redirect"
    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    Name = "${var.env_prefix}-lb-listener"
  }
}

resource "aws_lb_listener" "lb-listener-https" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-target-group.arn
  }

  tags = {
    Name = "${var.env_prefix}-lb-listener-https"
  }
}

