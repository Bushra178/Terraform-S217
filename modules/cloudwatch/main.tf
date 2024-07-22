### CloudWatch Log Group
resource "aws_cloudwatch_log_group" "wordpress_cwlog_group" {
  name = var.log_group_name
  
    tags = {
    Name = "wordpress-log-group"
  }
}

# Update CloudWatch Alarm for High CPU Utilization
resource "aws_cloudwatch_metric_alarm" "high_cpu_utilization" {
  alarm_name                = var.high_cpu_alarm_name
  comparison_operator       = var.high_cpu_comparison_operator
  evaluation_periods        = var.high_cpu_evaluation_periods
  metric_name               = var.high_cpu_metric_name
  namespace                 = var.high_cpu_namespace
  period                    = var.high_cpu_period
  statistic                 = var.high_cpu_statistics
  threshold                 = var.high_cpu_threshold
  alarm_description         = var.high_cpu_alarm_description
  dimensions = {
    ClusterName  = var.ecs_cluster_name
    ServiceName  = var.ecs_service_name
  }
  alarm_actions             = [var.scale_out_policy_arn]
  ok_actions                = [var.scale_in_policy_arn]
}

# Update CloudWatch Alarm for High Memory Utilization
resource "aws_cloudwatch_metric_alarm" "high_memory_utilization" {
  alarm_name                = var.high_memory_alarm_name
  comparison_operator       = var.high_memory_comparison_operator
  evaluation_periods        = var.high_memory_evaluation_periods
  metric_name               = var.high_memory_metric_name
  namespace                 = var.high_memory_namespace
  period                    = var.high_memory_period
  statistic                 = var.high_memory_statistics
  threshold                 = var.high_memory_threshold
  alarm_description         = var.high_memory_alarm_description

  dimensions = {
    ClusterName  = var.ecs_cluster_name
    ServiceName  = var.ecs_service_name
  }
  alarm_actions             = [var.scale_out_policy_arn]
  ok_actions                = [var.scale_in_policy_arn]
}

# Low CPU Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "low_cpu_utilization" {
  alarm_name                = var.low_cpu_alarm_name
  comparison_operator       = var.low_cpu_comparison_operator
  evaluation_periods        = var.low_cpu_evaluation_periods
  metric_name               = var.low_cpu_metric_name
  namespace                 = var.low_cpu_namespace
  period                    = var.low_cpu_period
  statistic                 = var.low_cpu_statistics
  threshold                 = var.low_cpu_threshold
  alarm_description         = var.low_cpu_alarm_description

  dimensions = {
    ClusterName  = var.ecs_cluster_name
    ServiceName  = var.ecs_service_name
  }
  alarm_actions             = [var.scale_in_policy_arn]
}

# Low Memory Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "low_memory_utilization" {
  alarm_name                = var.low_memory_alarm_name
  comparison_operator       = var.low_memory_comparison_operator
  evaluation_periods        = var.low_memory_evaluation_periods
  metric_name               = var.low_memory_metric_name
  namespace                 = var.low_memory_namespace
  period                    = var.low_memory_period
  statistic                 = var.low_memory_statistics
  threshold                 = var.low_memory_threshold
  alarm_description         = var.low_memory_alarm_description
  
  dimensions = {
    ClusterName  = var.ecs_cluster_name
    ServiceName  = var.ecs_service_name
  }
  alarm_actions             = [var.scale_in_policy_arn]
}
