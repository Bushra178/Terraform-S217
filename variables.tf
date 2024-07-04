variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "avail_zone" {
  description = "The availability zone to deploy resources"
  type        = string
}

variable "my_ip" {
  description = "The IP address to allow access"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
}

variable "image_name" {
  description = "The name of the image to use for the instance"
  type        = string
}

variable "app_prefix" {
  description = "Prefix to use for environment resources"
  type        = string
}

variable "wordpress_image_name" {
  description = "The name of the WordPress Docker image"
  type        = string
}

variable "db_name" {
  description = "The name of the RDS database"
  type        = string
}

variable "db_user" {
  description = "The username for the RDS database"
  type        = string
}

# variable "db_password" {
#   description = "The password for the RDS database"
#   type        = string
# }

variable "container_volume" {
  description = "The name of the container volume"
  type        = string
}

variable "container_volume_path" {
  description = "The path inside the container where the volume is mounted"
  type        = string
}

variable "default_route" {
  description = "The default route CIDR block"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the application"
  type        = string
}

variable "route_zone_name" {
  description = "The name of the route zone"
  type        = string
}

variable "alb_record_name" {
  description = "The record name for the ALB"
  type        = string
}

variable "subnet_cidr_block_1" {
  description = "The CIDR block for the first subnet"
  type        = string
}

variable "subnet_cidr_block_2" {
  description = "The CIDR block for the second subnet"
  type        = string
}

variable "subnet_cidr_block_3" {
  description = "The CIDR block for the third subnet"
  type        = string
}

variable "subnet_cidr_block_4" {
  description = "The CIDR block for the fourth subnet"
  type        = string
}

variable "az_1a" {
  description = "The first availability zone"
  type        = string
}

variable "az_1b" {
  description = "The second availability zone"
  type        = string
}

variable "ecs_family" {
  description = "The ECS task definition family"
  type        = string
}

# variable "ecs_network_mode" {
#   description = "The ECS network mode"
#   type        = string
# }

variable "ecs_os" {
  description = "The ECS operating system"
  type        = string
}

variable "ecs_cpu_architecture" {
  description = "The ECS CPU architecture"
  type        = string
}

variable "acm_ssl_policy" {
  description = "The SSL policy for ACM"
  type        = string
}

variable "db_allocated_storage" {
  description = "The allocated storage for the RDS instance"
  type        = number
}

variable "db_storage_type" {
  description = "The storage type for the RDS instance"
  type        = string
}

variable "db_engine" {
  description = "The database engine for the RDS instance"
  type        = string
}

variable "db_instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}

variable "db_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
}

variable "db_parameter_group_name" {
  description = "The parameter group name for the RDS instance"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}

variable "certificate_validation" {}

variable "wait_for_validation" {}

variable "route53_record_creation" {}

variable "method_for_validation" {}

variable "alternative_domain_name" {}

variable "ecs_cluster_name" {}
variable "log_group_retention" {}
variable "container_memory" {}
variable "container_cpu" {}
variable "container_port" {}
variable "host_port" {}
variable "container_protocol" {}
variable "log_driver" {}
variable "log_group" {}
variable "logs_region" {}
variable "logs_prefix" {}
variable "log_group_name" {}
variable "ecs_service_name" {}
variable "lb_container_name" {}
variable "lb_container_port" {}
variable "capacity_provider_weight" {}
variable "capacity_provider_base" {}
variable "ecs_provider_name" {}
variable "termination_protection" {}
variable "max_scaling_step_size" {}
variable "min_scaling_step_size" {}
variable "scaling_status" {}
variable "target_capacity" {}
variable "container_name" {}
variable "service_count" {}

variable "lb_name" {}
variable "lb_type" {}
variable "target_group_name" {}
variable "target_group_port" {}
variable "target_group_protocol" {}
variable "target_type" {}
variable "health_check_intervel" {}
variable "health_check_path" {}
variable "health_check_protocol" {}
variable "health_check_timeout" {}
variable "healthy_threshold" {}
variable "unhealthy_threshold" {}
variable "listener_port" {}
variable "listener_protocol" {}
variable "action_type" {}
variable "redirect_port" {}
variable "redirect_protocol" {}
variable "status_code" {}
variable "https_listener_port" {}
variable "https_listener_protocol" {}
variable "https_action_type" {}
variable "publicly_accessible" {}
variable "multi_az" {}
variable "skip_final_snapshot" {}
variable "final_snapshot_identifier" {}
variable "subnet_group_name" {}
variable "private_zone" {}
variable "record_type" {}
variable "evaluate_target_health" {}

variable "http_port" {}
variable "https_port" {}
variable "ingress_protocol" {}
variable "egress_protocol" {}
variable "wordpress_port" {}

variable "launch_config_name" {}
variable "autoscaling_group_name" {}
variable "asg_min_size" {}
variable "asg_max_size" {}
variable "asg_desired_capacity" {}
variable "scale_in_protection" {}
variable "asg_health_check_type" {}
variable "asg_health_check_grace_period" {}
variable "propagate_at_launch" {}
variable "scale_out_policy_name" {}
variable "scale_in_policy_name" {}
variable "scale_out_adjustment" {}
variable "scale_in_adjustment" {}
variable "scale_in_adjustment_type" {}
variable "scale_out_adjustment_type" {}
variable "scale_out_cooldown" {}
variable "scale_in_cooldown" {}

