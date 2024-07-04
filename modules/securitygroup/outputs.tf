output "asg_sg" {
    value = aws_security_group.wordpressApp_sg.id
}

output "rds_sg" {
    value = aws_security_group.rds_sg.id
}

output "alb_sg" {
    value = aws_security_group.wordpressApp_alb_sg.id
}


