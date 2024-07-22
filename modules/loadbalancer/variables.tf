variable "vpc_id" {
  description = "The ID of the VPC where resources will be created"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the resources"
  type        = string
}

variable "public_subnet_ids" {
  description = "The IDs of the public subnets"
  type        = list(string)
}

variable "app_prefix" {
  description = "The prefix to use for naming resources"
  type        = string
}

variable "certificate_arn" {
  description = "The ARN of the ACM certificate"
  type        = string
}

variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "lb_internal" {
  description = "Whether the load balancer is internal (true or false)"
  type        = bool
}

variable "lb_type" {
  description = "Type of load balancer (e.g., application, network)"
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


variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}

variable record_name {}