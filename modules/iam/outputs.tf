output "iam_instance_profile" {
    value = aws_iam_instance_profile.ecs_instance_profile.name
}

output "ecs_task_role" {
    value = aws_iam_role.ecs_task_role.arn
}