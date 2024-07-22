#Create alb
resource "aws_lb" "wordpres_lb" {
  name               = var.lb_name
  internal           = var.lb_internal
  load_balancer_type = var.lb_type
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnet_ids

  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-lb"
    }
  ) 
}

#Create target group for alb
resource "aws_lb_target_group" "lb_target_group" {
  name     = var.target_group_name
  port     = var.http_port
  protocol = var.http_protocol
  vpc_id   = var.vpc_id
  target_type = var.target_type

  health_check {
    //port                = "traffic-port"
    interval            = var.health_check_interval
    //protocol            = var.health_check_protocol
    timeout             = var.health_check_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    path                = var.health_check_path
    matcher             = "200"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-target_group"
    }
  ) 
}

#Create http listener
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.wordpres_lb.arn
  port              = var.http_port
  protocol          = var.http_protocol 

  default_action {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    type             = "redirect"
    redirect {
      port        = var.https_port
      protocol    = var.https_protocol
      status_code = var.lb_status_code
    }
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-lb_listener"
    }
  ) 
}

#Create https litener
resource "aws_lb_listener" "lb_listener_https" {
  load_balancer_arn = aws_lb.wordpres_lb.arn
  port              = var.https_port
  protocol          = var.https_protocol
  ssl_policy     = var.acm_ssl_policy
  certificate_arn = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-lb_listeber-https"
    }
  ) 
}
