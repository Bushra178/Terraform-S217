data "aws_route53_zone" "wp_route53_zone" {
  name = "xldp.xgrid.co"
  private_zone = false
}

resource "aws_route53_record" "alb_record" {
  zone_id = data.aws_route53_zone.wp_route53_zone.zone_id
  name    = "fatima-wordpressApp"
  type    = "A"

  alias {
    name                   = var.lb_dns_name
    zone_id                = var.lb_zone_id
    evaluate_target_health = true
  }
}

