output "security_group_id" {
    value = [aws_security_group.wordpressApp_sg.id]
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.ec2_autoscaling_group.name
}

output "scale_out_policy_arn" {
    value = aws_autoscaling_policy.scale_out_policy.arn
}

output "scale_in_policy_arn" {
    value = aws_autoscaling_policy.scale_in_policy.arn
}