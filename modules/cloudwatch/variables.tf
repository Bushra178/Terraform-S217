variable "autoscaling_group_name" {
  description = "Name of the Auto Scaling group associated with ECS instances."
  type        = string
}

variable "scale_out_policy_arn" {
  description = "ARN (Amazon Resource Name) of the scale-out policy for Auto Scaling."
  type        = string
}

variable "scale_in_policy_arn" {
  description = "ARN (Amazon Resource Name) of the scale-in policy for Auto Scaling."
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster where the service is deployed."
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service to manage containers."
  type        = string
}

