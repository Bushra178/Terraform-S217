# Create AWS Load Balancer
resource "aws_lb" "app_lb" {
  name               = var.lb_name
  load_balancer_type = var.lb_type
  security_groups    = [var.alb_sg]
  subnets            = var.public_subnet_ids

   tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-lb"
    }
  )
}

# ASG Target Group (Instance targets)
resource "aws_lb_target_group" "asg_target_group" {
  name       = var.target_group_name
  port       = var.target_group_port
  protocol   = var.target_group_protocol
  vpc_id     = var.vpc_id
  target_type = var.target_type

  health_check {
    interval            = var.health_check_intervel
    path                = var.health_check_path
    protocol            = var.health_check_protocol
    timeout             = var.health_check_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }

   tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-target-group"
    }
  )
}

#ECS Target Group (IP targets)
# resource "aws_lb_target_group" "ecs_target_group" {
#   name     = "ecs-target-group"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = var.vpc_id
#   target_type = "ip" 

#   health_check {
#     interval            = 30
#     path                = "/"
#     protocol            = "HTTP"
#     timeout             = 5
#     healthy_threshold   = 3
#     unhealthy_threshold = 3
#   }

#   tags = {
#     Name = "${var.env_prefix}-ecs-target-group"
#     app = "wordpress"
#     created-by = "Bushra Fatima"
#     environment = "XLDP - dev"
#     project = "S217-XLDP"
#     owner = "Bushra Fatima"
#     team = "Firebirds"
#   }
# }

#Create alb listener
resource "aws_lb_listener" "lb-listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type          = var.action_type
    redirect {
      port        = var.redirect_port
      protocol    = var.redirect_protocol
      status_code = var.status_code
    }
  }

   tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-lb-listener"
    }
  )
}

resource "aws_lb_listener" "lb_listener_https" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = var.https_listener_port
  protocol          = var.https_listener_protocol
  ssl_policy        = var.acm_ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.https_action_type
    target_group_arn = aws_lb_target_group.asg_target_group.arn  # Default to ECS target group
  }

   tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-lb-https-listener"
    }
  )
}

# Listener Rule for ECS Target Group
# resource "aws_lb_listener_rule" "ecs_rule" {
#   listener_arn = aws_lb_listener.lb_listener_https.arn
#   priority     = 10

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.ecs_target_group.arn
#   }

#   condition {
#     path_pattern {
#       values = ["/ecs/*"]
#     }
# }
# }
  
# # Listener Rule for ASG Target Group
# resource "aws_lb_listener_rule" "asg_rule" {
#   listener_arn = aws_lb_listener.lb_listener_https.arn
#   priority     = 20

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.asg_target_group.arn
#   }

#   condition {
#     path_pattern {
#       values = ["/asg/*"]
#     }
# }
# }

