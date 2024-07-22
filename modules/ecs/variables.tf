variable "lb_target_group_arn" {
  description = "The ARN of the load balancer target group."
  type        = string
}

variable "ecs_task_role" {
  description = "The IAM role for the ECS task."
  type        = string
}

variable "ecs_service_role" {
  description = "The IAM role for the ECS service."
  type        = string
}

variable "task_execution_role" {
  description = "The IAM role for task execution."
  type        = string
}

variable "db_endpoint" {
  description = "The endpoint for the database."
  type        = string
}

variable "db_password" {
  description = "The password for the database."
  type        = string
}

variable "log_group_name" {
  description = "The name of the CloudWatch log group."
  type        = string
}

variable "cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
}

variable "task_family" {
  description = "The family of the ECS task definition."
  type        = string
}

variable "network_mode" {
  description = "The network mode for the ECS task definition."
  type        = string
}

variable "volume_name" {
  description = "The name of the volume for the ECS task."
  type        = string
}

variable "host_path" {
  description = "The host path for the ECS task volume."
  type        = string
}

variable "container_name" {
  description = "The name of the container in the ECS task."
  type        = string
}

variable "container_image" {
  description = "The image for the container in the ECS task."
  type        = string
}

variable "container_memory" {
  description = "The amount of memory for the container in the ECS task."
  type        = number
}

variable "container_cpu" {
  description = "The amount of CPU units for the container in the ECS task."
  type        = number
}

variable "container_essentials" {
  description = "Whether the container is essential in the ECS task."
  type        = bool
}

variable "container_port" {
  description = "The container port for the container in the ECS task."
  type        = number
}

variable "container_host_port" {
  description = "The host port for the container in the ECS task."
  type        = number
}

variable "container_protocol" {
  description = "The protocol for the container port in the ECS task."
  type        = string
}

variable "db_name" {
  description = "The name of the database."
  type        = string
}

variable "db_user" {
  description = "The username for the database."
  type        = string
}

variable "log_driver" {
  description = "The log driver for the ECS task."
  type        = string
}

variable "logs_region" {
  description = "The AWS region for the CloudWatch logs."
  type        = string
}

variable "logs_stream_prefix" {
  description = "The stream prefix for the CloudWatch logs."
  type        = string
}

variable "ecs_service_name" {
  description = "The name of the ECS service."
  type        = string
}

variable "service_launch_type" {
  description = "The launch type for the ECS service (e.g., EC2 or FARGATE)."
  type        = string
}

variable "service_desired_count" {
  description = "The desired number of instances for the ECS service."
  type        = number
}

variable "app_prefix" {
  description = "The prefix for naming resources in the application."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}

variable "secret_policy_arn" {
  description = "ARN of the secret for db password"
  type = string
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs"
  type        = list(string)
}

variable "sg_id" {
  description = "ECS security group id"
  type = string
}
