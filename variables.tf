variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "avail_zone" {
  description = "The availability zone for the resources"
  type        = string
}

variable "my_ip" {
  description = "The IP address to allow access to resources"
  type        = string
}

variable "instance_type" {
  description = "The instance type for EC2 instances"
  type        = string
}

variable "image_name" {
  description = "The name of the AMI to use for EC2 instances"
  type        = string
}

variable "app_prefix" {
  description = "The environment prefix to use for naming resources"
  type        = string
}

variable "domain_name" {
  description = "The domain name to use for Route 53"
  type        = string
}

variable "route_zone_name" {
  description = "The name of the Route 53 hosted zone"
  type        = string
}

variable "alb_record_name" {
  description = "The name of the record for the ALB"
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

variable "default_route" {
  description = "The default route for the route table"
  type        = string
}
variable "ssh_public_key_path" {
  description = "The path to the SSH public key file"
  type        = string
}

variable "validate_certificate" {
  description = "Whether to validate the certificate"
  type        = bool
}

variable "wait_for_validation" {
  description = "Whether to wait for certificate validation"
  type        = bool
}

variable "create_route53_records" {
  description = "Whether to create Route 53 records for validation"
  type        = bool
}

variable "validation_method" {
  description = "Validation method for the certificate (e.g., EMAIL, DNS)"
  type        = string
}

variable "subject_alternative_names" {
  description = "Subject alternative names for the certificate"
  type        = string
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "task_family" {
  description = "Family name for the ECS task definition"
  type        = string
}

variable "network_mode" {
  description = "Network mode for the ECS task (e.g., bridge, awsvpc)"
  type        = string
}

variable "volume_name" {
  description = "Name of the volume to attach to the ECS task"
  type        = string
}

variable "host_path" {
  description = "Host path for the volume to attach to the ECS task"
  type        = string
}

variable "container_name" {
  description = "Name of the container within the ECS task definition"
  type        = string
}

variable "container_image" {
  description = "Docker image for the container within the ECS task definition"
  type        = string
}

variable "container_memory" {
  description = "Memory (in MiB) to allocate to the container within the ECS task definition"
  type        = number
}

variable "container_cpu" {
  description = "CPU units to allocate to the container within the ECS task definition"
  type        = number
}

variable "container_essentials" {
  description = "Essential flag for the container within the ECS task definition"
  type        = bool
}

variable "container_port" {
  description = "Port number exposed by the container within the ECS task definition"
  type        = number
}

variable "container_host_port" {
  description = "Host port number mapped to the container port within the ECS task definition"
  type        = number
}

variable "container_protocol" {
  description = "Protocol used for the container port within the ECS task definition"
  type        = string
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_user" {
  description = "Username for the database"
  type        = string
}

variable "log_driver" {
  description = "Log driver for the ECS task definition (e.g., awslogs)"
  type        = string
}

variable "logs_region" {
  description = "Region for logging (e.g., us-east-1)"
  type        = string
}

variable "logs_stream_prefix" {
  description = "Prefix for log streams"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "service_launch_type" {
  description = "Launch type for the ECS service (e.g., EC2, FARGATE)"
  type        = string
}

variable "service_desired_count" {
  description = "Desired number of tasks in the ECS service"
  type        = number
}

variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "lb_internal" {
  description = "Whether the load balancer is internal"
  type        = bool
}

variable "lb_type" {
  description = "Type of the load balancer (e.g., application, network)"
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group associated with the load balancer"
  type        = string
}

variable "target_type" {
  description = "Type of targets (e.g., instance, ip, lambda)"
  type        = string
}

variable "health_check_interval" {
  description = "Interval between health checks in seconds"
  type        = number
}

variable "health_check_path" {
  description = "Path used for HTTP/HTTPS health checks"
  type        = string
}

variable "health_check_protocol" {
  description = "Protocol used for health checks (HTTP, HTTPS, TCP, SSL, etc.)"
  type        = string
}

variable "health_check_timeout" {
  description = "Timeout for health checks in seconds"
  type        = number
}

variable "healthy_threshold" {
  description = "Number of consecutive successful health checks to consider an instance healthy"
  type        = number
}

variable "unhealthy_threshold" {
  description = "Number of consecutive failed health checks to consider an instance unhealthy"
  type        = number
}

variable "http_port" {
  description = "HTTP port of the target (if applicable)"
  type        = number
}

variable "http_protocol" {
  description = "Protocol used for HTTP listener (HTTP, HTTPS)"
  type        = string
}

variable "https_port" {
  description = "HTTPS port of the target (if applicable)"
  type        = number
}

variable "https_protocol" {
  description = "Protocol used for HTTPS listener (HTTP, HTTPS)"
  type        = string
}

variable "lb_status_code" {
  description = "Expected HTTP status code from the load balancer (if applicable)"
  type        = string
}

variable "acm_ssl_policy" {
  description = "SSL policy for ACM (AWS Certificate Manager) SSL certificates"
  type        = string
}

variable "db_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated storage in gigabytes for the RDS instance"
  type        = number
}

variable "db_storage_type" {
  description = "Storage type for the RDS instance (e.g., gp2, io1)"
  type        = string
}

variable "db_engine" {
  description = "Database engine type (e.g., mysql, postgres)"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class (e.g., db.t2.micro, db.m5.large)"
  type        = string
}

variable "db_user_name" {
  description = "Username for the master database user"
  type        = string
}

variable "db_param_group" {
  description = "Parameter group name or ARN to associate with the RDS instance"
  type        = string
}

variable "db_skip_final_snapshot" {
  description = "Whether to skip the final snapshot when deleting the RDS instance (true/false)"
  type        = bool
}

variable "db_final_snapshot_identifier" {
  description = "Identifier for the final snapshot when deleting the RDS instance"
  type        = string
}

variable "db_subnet_name" {
  description = "Name of the subnet group where the RDS instance will be deployed"
  type        = string
}

variable "pwd_length" {
  description = "Length of the generated password"
  type        = number
}

variable "pwd_special" {
  description = "Whether to include special characters in the generated password (true/false)"
  type        = bool
}

variable "pwd_override_special" {
  description = "Specific set of special characters to include in the generated password (optional)"
  type        = string
}

variable "secret_name" {
  description = "Name of the secret in AWS Secrets Manager or other secret management service"
  type        = string
}

variable "route53_private_zone" {
  description = "Name or ID of the private Route 53 hosted zone"
  type        = bool
}

variable "route53_type" {
  description = "Type of Route 53 record (e.g., A, CNAME, Alias)"
  type        = string
}

variable "route53_health" {
  description = "Health check configuration for Route 53 records (optional)"
  type        = bool
}

variable "egress_port" {
  description = "Port number for egress traffic (outbound)"
  type        = number
}

variable "db_sg_port" {
  description = "Port number for database security group rules"
  type        = number
}

variable "rds_sg_name" {
  description = "Name of the security group for the RDS instance"
  type        = string
}

variable "map_public_ip" {
  description = "Whether to map a public IP address to instances launched in a subnet"
  type        = bool
}

variable "eip_domain" {
  description = "Domain for the Elastic IP address (vpc or standard)"
  type        = string
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair used to access instances"
  type        = string
}

variable "launch_config_name" {
  description = "Name of the EC2 launch configuration"
  type        = string
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group (ASG)"
  type        = string
}

variable "asg_min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
}

variable "asg_max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
}

variable "health_check_type" {
  description = "Type of health check for instances in the Auto Scaling Group (EC2 or ELB)"
  type        = string
}

variable "asg_health_check_period" {
  description = "Time (in seconds) between health checks for instances in the Auto Scaling Group"
  type        = number
}

variable "propagate_at_launch" {
  description = "Whether instances inherit security group and subnet attributes from ASG"
  type        = bool
}

variable "scale_out_policy_name" {
  description = "Name of the scale out policy for the Auto Scaling Group"
  type        = string
}

variable "scale_in_policy_name" {
  description = "Name of the scale in policy for the Auto Scaling Group"
  type        = string
}

variable "scale_out_adjustment" {
  description = "Number of instances to add when scaling out"
  type        = number
}

variable "scale_in_adjustment" {
  description = "Number of instances to remove when scaling in"
  type        = number
}

variable "scale_in_adjustment_type" {
  description = "Type of adjustment for scale in (ChangeInCapacity, ExactCapacity, PercentChangeInCapacity)"
  type        = string
}

variable "scale_out_adjustment_type" {
  description = "Type of adjustment for scale out (ChangeInCapacity, ExactCapacity, PercentChangeInCapacity)"
  type        = string
}

variable "scale_out_cooldown" {
  description = "Cooldown period (in seconds) for scaling out activities"
  type        = number
}

variable "scale_in_cooldown" {
  description = "Cooldown period (in seconds) for scaling in activities"
  type        = number
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
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
