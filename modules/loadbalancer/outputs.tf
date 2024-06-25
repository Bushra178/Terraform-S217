output "lb_target_group_arn" {
  value = aws_lb_target_group.lb-target-group.arn
}

output "lb_zone_id" {
  value = aws_lb.app_lb.zone_id
}

output "lb_dns_name" {
  value = aws_lb.app_lb.dns_name
}