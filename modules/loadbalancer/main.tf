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

# data "aws_route53_zone" "wp_route53_zone" {
#   name = "xldp.xgrid.co"
#   private_zone = false
# }

# resource "aws_route53_zone" "wordpress_app_route" {
#   name = "fatima.xldp.xgrid.co"

#   tags = {
#     Name = "${var.env_prefix}-route-zone"
#   }
# }

# resource "aws_route53_record" "alb_record" {
#   zone_id = data.aws_route53_zone.wp_route53_zone.zone_id
#   name    = "fatima-wordpressApp"
#   type    = "A"

#   alias {
#     name                   = aws_lb.app_lb.dns_name
#     zone_id                = aws_lb.app_lb.zone_id
#     evaluate_target_health = true
#   }
#   //records = [aws_lb.app_lb.dns_name]
# }

# resource "aws_route53_record" "app_certificate_validation" {
#   for_each = {
#     for dvo in aws_acm_certificate.app_certificate.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       type   = dvo.resource_record_type
#       record = dvo.resource_record_value
#     }
#   }

#   zone_id = aws_route53_zone.wordpress_app_route.zone_id
#   name    = each.value.name
#   type    = each.value.type
#   ttl     = 60
#   records = [each.value.record]
# }

# resource "aws_acm_certificate" "app_certificate" {
#   domain_name       = "fatima-wp-app.xgrid.co"
#   validation_method = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }

#   tags = {
#     Name = "${var.env_prefix}-acm-certificate"
#   }
# }

# resource "aws_acm_certificate_validation" "wordpress_dns_validation" {
#   certificate_arn         = aws_acm_certificate.app_certificate.arn
#   validation_record_fqdns = [for record in aws_route53_record.app_certificate_validation : record.fqdn]

#   timeouts {
#     create = "30m"
#   }
# }


# module "copebit_terraform_acm_test" {
#   source                    = "terraform-aws-modules/acm/aws"
#   version                   = "~> 5.0"
#   domain_name               = "fatima.xldp.xgrid.co"
#   zone_id                   = data.aws_route53_zone.wp_route53_zone.zone_id
#   validate_certificate      = true
#   wait_for_validation       = true
#   create_route53_records    = true
#   validation_method         = "DNS"
# }