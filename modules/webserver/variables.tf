variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "image_name" {
  description = "The name of the AMI to use for the instance"
  type        = string
}

variable "avail_zone" {
  description = "The availability zone to deploy resources in"
  type        = string
}

variable "my_ip" {
  description = "The IP address to allow access from"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "asg_target_group_arn" {
  description = "The ARN of the target group for the Auto Scaling Group"
  type        = string
}

variable "app_prefix" {
  description = "Prefix to use for environment resources"
  type        = string
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to associate with the instances"
  type        = string
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "asg_sg" {
  description = "The ID of the security group"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}

variable launch_config_name {}
variable autoscaling_group_name {}
variable asg_min_size {}
variable asg_max_size {}
variable asg_desired_capacity {}
variable scale_in_protection {}
variable asg_health_check_type {}
variable asg_health_check_grace_period {}
variable propagate_at_launch {}
variable scale_out_policy_name {}
variable scale_in_policy_name {}
variable scale_out_adjustment {}
variable scale_in_adjustment {}
variable scale_in_adjustment_type {}
variable scale_out_adjustment_type {}
variable scale_out_cooldown {}
variable scale_in_cooldown {}




