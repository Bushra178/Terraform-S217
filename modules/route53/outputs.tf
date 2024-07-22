output "route53_zone_id" {
  value = data.aws_route53_zone.wp_route53_zone.zone_id
}

output "record_name" {
  value = aws_route53_record.alb_reecord.name
}