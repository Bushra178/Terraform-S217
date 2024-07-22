output "log_group_name" {
  value = aws_cloudwatch_log_group.wordpress_cwlog_group.name
}
