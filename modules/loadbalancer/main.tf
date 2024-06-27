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

# ASG Target Group (Instance targets)
resource "aws_lb_target_group" "asg_target_group" {
  name       = "asg-target-group"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = var.vpc_id
  target_type = "instance"

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "${var.env_prefix}-asg-target-group"
  }
}

#ECS Target Group (IP targets)
resource "aws_lb_target_group" "ecs_target_group" {
  name     = "ecs-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip" 

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "${var.env_prefix}-ecs-target-group"
  }
}


resource "aws_lb_listener" "lb-listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP" 

  default_action {
    type          = "redirect"
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

resource "aws_lb_listener" "lb_listener_https" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_target_group.arn  # Default to ECS target group
  }

  tags = {
    Name = "${var.env_prefix}-lb-listener-https"
  }
}

# Listener Rule for ECS Target Group
resource "aws_lb_listener_rule" "ecs_rule" {
  listener_arn = aws_lb_listener.lb_listener_https.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/ecs/*"]
    }
}
}
  
# Listener Rule for ASG Target Group
resource "aws_lb_listener_rule" "asg_rule" {
  listener_arn = aws_lb_listener.lb_listener_https.arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/asg/*"]
    }
}
}


