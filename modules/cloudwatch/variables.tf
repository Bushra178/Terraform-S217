variable "autoscaling_group_name" {
  description = "The name of the Auto Scaling group"
  type        = string
}

variable "scale_out_policy_arn" {
  description = "The ARN of the scale-out policy for the Auto Scaling group"
  type        = string
}

variable "scale_in_policy_arn" {
  description = "The ARN of the scale-in policy for the Auto Scaling group"
  type        = string
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster where the services will be deployed."
  type        = string
}

variable "ecs_service_name" {
  description = "The name of the ECS service."
  type        = string
}

variable "log_group_name" {
  description = "Name of the CloudWatch Logs log group."
  type        = string
}

// High CPU Alarm Variables
variable "high_cpu_alarm_name" {
  description = "Name of the CloudWatch alarm for high CPU utilization."
  type        = string
}

variable "high_cpu_comparison_operator" {
  description = "Comparison operator used for high CPU utilization threshold."
  type        = string
}

variable "high_cpu_evaluation_periods" {
  description = "Number of periods over which to evaluate the high CPU threshold."
  type        = string
}

variable "high_cpu_metric_name" {
  description = "Name of the CloudWatch metric for high CPU utilization."
  type        = string
}

variable "high_cpu_namespace" {
  description = "Namespace of the CloudWatch metric for high CPU utilization."
  type        = string
}

variable "high_cpu_period" {
  description = "Period (in seconds) for the high CPU CloudWatch metric."
  type        = string
}

variable "high_cpu_statistics" {
  description = "Statistic used for the high CPU CloudWatch metric (e.g., Average, Maximum)."
  type        = string
}

variable "high_cpu_threshold" {
  description = "Threshold value for high CPU utilization."
  type        = string
}

variable "high_cpu_alarm_description" {
  description = "Description of the CloudWatch alarm for high CPU utilization."
  type        = string
}

// High Memory Alarm Variables
variable "high_memory_alarm_name" {
  description = "Name of the CloudWatch alarm for high memory utilization."
  type        = string
}

variable "high_memory_comparison_operator" {
  description = "Comparison operator used for high memory utilization threshold."
  type        = string
}

variable "high_memory_evaluation_periods" {
  description = "Number of periods over which to evaluate the high memory threshold."
  type        = string
}

variable "high_memory_metric_name" {
  description = "Name of the CloudWatch metric for high memory utilization."
  type        = string
}

variable "high_memory_namespace" {
  description = "Namespace of the CloudWatch metric for high memory utilization."
  type        = string
}

variable "high_memory_period" {
  description = "Period (in seconds) for the high memory CloudWatch metric."
  type        = string
}

variable "high_memory_statistics" {
  description = "Statistic used for the high memory CloudWatch metric (e.g., Average, Maximum)."
  type        = string
}

variable "high_memory_threshold" {
  description = "Threshold value for high memory utilization."
  type        = string
}

variable "high_memory_alarm_description" {
  description = "Description of the CloudWatch alarm for high memory utilization."
  type        = string
}

// Low CPU Alarm Variables
variable "low_cpu_alarm_name" {
  description = "Name of the CloudWatch alarm for low CPU utilization."
  type        = string
}

variable "low_cpu_comparison_operator" {
  description = "Comparison operator used for low CPU utilization threshold."
  type        = string
}

variable "low_cpu_evaluation_periods" {
  description = "Number of periods over which to evaluate the low CPU threshold."
  type        = string
}

variable "low_cpu_metric_name" {
  description = "Name of the CloudWatch metric for low CPU utilization."
  type        = string
}

variable "low_cpu_namespace" {
  description = "Namespace of the CloudWatch metric for low CPU utilization."
  type        = string
}

variable "low_cpu_period" {
  description = "Period (in seconds) for the low CPU CloudWatch metric."
  type        = string
}

variable "low_cpu_statistics" {
  description = "Statistic used for the low CPU CloudWatch metric (e.g., Average, Minimum)."
  type        = string
}

variable "low_cpu_threshold" {
  description = "Threshold value for low CPU utilization."
  type        = string
}

variable "low_cpu_alarm_description" {
  description = "Description of the CloudWatch alarm for low CPU utilization."
  type        = string
}

// Low Memory Alarm Variables
variable "low_memory_alarm_name" {
  description = "Name of the CloudWatch alarm for low memory utilization."
  type        = string
}

variable "low_memory_comparison_operator" {
  description = "Comparison operator used for low memory utilization threshold."
  type        = string
}

variable "low_memory_evaluation_periods" {
  description = "Number of periods over which to evaluate the low memory threshold."
  type        = string
}

variable "low_memory_metric_name" {
  description = "Name of the CloudWatch metric for low memory utilization."
  type        = string
}

variable "low_memory_namespace" {
  description = "Namespace of the CloudWatch metric for low memory utilization."
  type        = string
}

variable "low_memory_period" {
  description = "Period (in seconds) for the low memory CloudWatch metric."
  type        = string
}

variable "low_memory_statistics" {
  description = "Statistic used for the low memory CloudWatch metric (e.g., Average, Minimum)."
  type        = string
}

variable "low_memory_threshold" {
  description = "Threshold value for low memory utilization."
  type        = string
}

variable "low_memory_alarm_description" {
  description = "Description of the CloudWatch alarm for low memory utilization."
  type        = string
}
