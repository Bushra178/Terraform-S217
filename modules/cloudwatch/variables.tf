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