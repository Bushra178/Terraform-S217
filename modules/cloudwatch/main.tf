# ECS CPU Utilization High Alarm
resource "aws_cloudwatch_metric_alarm" "ecs_high_cpu_utilization" {
  alarm_name                = "ECSHighCPUUtilization"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/ECS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "40"
  alarm_description         = "This alarm monitors high CPU utilization for the ECS service"
  dimensions = {
    ClusterName  = var.ecs_cluster_name
    ServiceName  = var.ecs_service_name
  }
  alarm_actions             = [var.scale_out_policy_arn]
  ok_actions                = [var.scale_in_policy_arn]
}

# ECS Memory Utilization High Alarm
resource "aws_cloudwatch_metric_alarm" "ecs_high_memory_utilization" {
  alarm_name                = "ECSHighMemoryUtilization"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "MemoryUtilization"
  namespace                 = "AWS/ECS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "60"
  alarm_description         = "This alarm monitors high memory utilization for the ECS service"
  dimensions = {
    ClusterName  = var.ecs_cluster_name
    ServiceName  = var.ecs_service_name
  }
  alarm_actions             = [var.scale_out_policy_arn]
  ok_actions                = [var.scale_in_policy_arn]
}

# ECS CPU Utilization Low Alarm
resource "aws_cloudwatch_metric_alarm" "ecs_low_cpu_utilization" {
  alarm_name                = "ECSLowCPUUtilization"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/ECS"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "20"
  alarm_description         = "This alarm monitors low CPU utilization for the ECS service"
  dimensions = {
    ClusterName  = var.ecs_cluster_name
    ServiceName  = var.ecs_service_name
  }
  alarm_actions             = [var.scale_in_policy_arn]
}

# ECS Memory Utilization Low Alarm
resource "aws_cloudwatch_metric_alarm" "ecs_low_memory_utilization" {
  alarm_name                = "ECSLowMemoryUtilization"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "MemoryUtilization"
  namespace                 = "AWS/ECS"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "30"
  alarm_description         = "This alarm monitors low memory utilization for the ECS service"
  dimensions = {
    ClusterName  = var.ecs_cluster_name
    ServiceName  = var.ecs_service_name
  }
  alarm_actions             = [var.scale_in_policy_arn]
}
