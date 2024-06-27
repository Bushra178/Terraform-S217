output "security_group_id" {
    value = [aws_security_group.wordpressApp_sg.id]
}