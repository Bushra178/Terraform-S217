output "asg_sg_id" {
    value = aws_security_group.wordpressApp_sg.id
}

output "alb_sg_id" {
    value = aws_security_group.wordpressApp_alb_sg.id
}

output "rds_sg_id" {
    value = aws_security_group.rds_sg.id
}

output "jum_sg_id" {
  value = aws_security_group.jump_server_sg.id
}
