# output "asg_instance_ids" {
#   value = aws_autoscaling_group.ec2_autoscaling_group.instances
# }

output "security_group_id" {
    value = [aws_security_group.wordpressApp_sg.id]
}




