variable "vpc_id" {
  description = "The ID of the VPC where resources will be created"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the resources"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "The IDs of the public subnets"
  type        = list(string)
}

variable "env_prefix" {
  description = "The prefix to use for naming resources"
  type        = string
}

variable "certificate_arn" {
  description = "The ARN of the ACM certificate"
  type        = string
}