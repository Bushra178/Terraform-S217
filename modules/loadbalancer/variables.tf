variable "vpc_id" {
  description = "The ID of the Virtual Private Cloud (VPC) where resources will be deployed."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of IDs of the public subnets within the specified VPC."
  type        = list(string)
}

variable "app_prefix" {
  description = "Prefix used to identify or namespace resources, ensuring uniqueness."
  type        = string
}

variable "certificate_arn" {
  description = "Amazon Resource Name (ARN) of the SSL certificate used for secure communication."
  type        = string
}

variable "alb_sg" {
  description = "Security Group ID (SG-ID) associated with the Application Load Balancer (ALB)."
  type        = string
}

variable "acm_ssl_policy" {
  description = "SSL policy applied to the AWS Certificate Manager (ACM) certificate for SSL/TLS configurations."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}

variable lb_name {}
variable lb_type {}
variable target_group_name {}
variable target_group_port {}
variable target_group_protocol {}
variable target_type {}
variable health_check_intervel {}
variable health_check_path {}
variable health_check_protocol {}
variable health_check_timeout {}
variable healthy_threshold {}
variable unhealthy_threshold {}
variable listener_port {}
variable listener_protocol {}
variable action_type {}
variable redirect_port {}
variable redirect_protocol {}
variable status_code {}
variable https_listener_port {}
variable https_listener_protocol {}
variable https_action_type {}





