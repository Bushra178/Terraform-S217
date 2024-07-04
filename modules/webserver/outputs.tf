output "autoscaling_group_name" {
  value = aws_autoscaling_group.ec2_autoscaling_group.name
}

output "autoscaling_group_arn" {
  value = aws_autoscaling_group.ec2_autoscaling_group.arn
}

output "scale_out_policy_arn" {
    value = aws_autoscaling_policy.scale_out_policy.arn
}

output "scale_in_policy_arn" {
    value = aws_autoscaling_policy.scale_in_policy.arn
}



