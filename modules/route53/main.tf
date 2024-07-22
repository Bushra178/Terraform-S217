#Get route53 zone name
data "aws_route53_zone" "wp_route53_zone" {
  name = var.route_zone_name
  private_zone = var.route53_private_zone
}

#Create route53 record
resource "aws_route53_record" "alb_reecord" {
  zone_id = data.aws_route53_zone.wp_route53_zone.zone_id
  name    = var.alb_record_name
  type    = var.route53_type

  alias {
    name                   = var.lb_dns_name
    zone_id                = var.lb_zone_id
    evaluate_target_health = var.route53_health
  }
}
