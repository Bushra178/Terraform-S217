output "ecs_instance_profile" {
    value = aws_iam_instance_profile.ecs_asg_instance_profile.arn
}

output "ecs_task_role" {
    value = aws_iam_role.ecs_task_role.arn
}

output "ecs_service_role" {
    value = aws_iam_role.ecs_service_role.arn
}

output "task_execution_role" {
    value = aws_iam_role.ecs_execution_role.arn
}
