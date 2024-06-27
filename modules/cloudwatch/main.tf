# Update CloudWatch Alarm for High CPU Utilization
resource "aws_cloudwatch_metric_alarm" "high_cpu_utilization" {
  alarm_name                = "high-cpu-utilization"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "40"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  dimensions                = {
    AutoScalingGroupName = var.autoscaling_group_name
  }
  alarm_actions             = [var.scale_out_policy_arn]
  ok_actions                = [var.scale_in_policy_arn]
}

# Update CloudWatch Alarm for High Memory Utilization
resource "aws_cloudwatch_metric_alarm" "high_memory_utilization" {
  alarm_name                = "high-memory-utilization"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "MemoryUtilization"
  namespace                 = "System/Linux"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "60"
  alarm_description         = "This metric monitors ec2 memory utilization"
  dimensions                = {
    AutoScalingGroupName = var.autoscaling_group_name
  }
  alarm_actions             = [var.scale_out_policy_arn]
  ok_actions                = [var.scale_in_policy_arn]
}

# Low CPU Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "low_cpu_utilization" {
  alarm_name                = "LowCPUUtilization"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "20"
  alarm_description         = "This alarm triggers if CPU utilization is less than 20% for 2 consecutive periods."
  dimensions                = {
    AutoScalingGroupName = var.autoscaling_group_name
  }
  alarm_actions             = [var.scale_in_policy_arn]
}

# Low Memory Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "low_memory_utilization" {
  alarm_name                = "LowMemoryUtilization"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "MemoryUtilization"
  namespace                 = "CWAgent"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "30"
  alarm_description         = "This alarm triggers if memory utilization is less than 30% for 2 consecutive periods."
  dimensions                = {
    AutoScalingGroupName = var.autoscaling_group_name
  }
  alarm_actions             = [var.scale_in_policy_arn]
}