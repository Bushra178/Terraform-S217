# output "ecs_target_group_arn" {
#   value = aws_lb_target_group.ecs_target_group.arn
# }

output "asg_target_group_arn" {
  value = aws_lb_target_group.asg_target_group.arn
}

output "lb_zone_id" {
  value = aws_lb.app_lb.zone_id
}

output "lb_dns_name" {
  value = aws_lb.app_lb.dns_name
}


