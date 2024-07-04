variable "wordpress_image_name" {
  description = "Name of the Docker image for the WordPress application."
  type        = string
}

variable "db_name" {
  description = "Name of the database to be used by WordPress."
  type        = string
}

variable "db_user" {
  description = "Username for accessing the database."
  type        = string
}

variable "db_password" {
  description = "Password for the database user."
  type        = string
}

variable "db_address" {
  description = "Address or endpoint of the database server."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of IDs of the public subnets within the specified VPC."
  type        = list(string)
}

variable "ecs_target_group_arn" {
  description = "ARN (Amazon Resource Name) of the Application Load Balancer (ALB) target group."
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID (SG-ID) for the ECS instances."
  type        = string
}

variable "app_prefix" {
  description = "Prefix used to identify or namespace resources, ensuring uniqueness."
  type        = string
}

variable "autoscaling_group_arn" {
  description = "ARN of the Auto Scaling group associated with ECS."
  type        = string
}

variable "ecs_task_role" {
  description = "IAM role ARN used by ECS tasks."
  type        = string
}

variable "container_volume" {
  description = "Name of the container volume to be mounted."
  type        = string
}

variable "container_volume_path" {
  description = "Path where the container volume is mounted."
  type        = string
}

variable "ecs_family" {
  description = "Family name of the ECS task definition."
  type        = string
}

# variable "ecs_network_mode" {
#   description = "Network mode used by ECS tasks (e.g., awsvpc)."
#   type        = string
# }

variable "ecs_os" {
  description = "Operating system used by ECS instances (e.g., linux)."
  type        = string
}

variable "ecs_cpu_architecture" {
  description = "CPU architecture used by ECS instances (e.g., x86_64)."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}

variable ecs_cluster_name {}
variable log_group_retention {}
variable container_memory {}
variable container_cpu {}
variable container_port {}
variable host_port {}
variable container_protocol {}
variable log_driver {}
variable log_group {}
variable logs_region {}
variable logs_prefix {}
variable log_group_name {}
variable ecs_service_name {}
variable lb_container_name {}
variable lb_container_port {}
variable capacity_provider_weight {}
variable capacity_provider_base {}
variable ecs_provider_name {}
variable termination_protection {}
variable max_scaling_step_size {}
variable min_scaling_step_size {}
variable scaling_status {}
variable target_capacity {}
variable container_name {}
variable service_count {}





























# variable "dependency" {
#   description = "The reource which should be created first"
#   type        = string
# }


