data "aws_route53_zone" "wp_route53_zone" {
  name = "xldp.xgrid.co"
  private_zone = false
}

# resource "aws_route53_zone" "wordpress_app_route" {
#   name = "fatima.xldp.xgrid.co"

#   tags = {
#     Name = "${var.env_prefix}-route-zone"
#   }
# }

resource "aws_route53_record" "alb_record" {
  zone_id = data.aws_route53_zone.wp_route53_zone.zone_id
  name    = "fatima-wordpressApp"
  type    = "A"

  alias {
    name                   = var.lb_dns_name
    zone_id                = var.lb_zone_id
    evaluate_target_health = true
  }
  //records = [aws_lb.app_lb.dns_name]
}

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