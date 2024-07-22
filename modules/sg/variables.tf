variable "default_route" {
  description = "The default route for routing traffic within a VPC."
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the Virtual Private Cloud (VPC)."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the Virtual Private Cloud (VPC) where resources will be deployed."
  type        = string
}

variable "app_prefix" {
  description = "Prefix used in naming a resource."
  type        = string
}

variable "my_ip" {
  description = "The IP address representing your current location or authorized IP for access."
  type        = string
}
variable "http_port" {
  description = "Port number for HTTP traffic"
  type        = number
}

variable "https_port" {
  description = "Port number for HTTPS traffic"
  type        = number
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

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}
