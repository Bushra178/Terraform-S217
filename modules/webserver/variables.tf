variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "image_name" {
  description = "The name of the AMI to use for instances"
  type        = string
}

variable "avail_zone" {
  description = "The availability zone to be used"
  type        = string
}

variable "my_ip" {
  description = "The IP address of the user"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for EC2 instances"
  type        = string
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs"
  type        = list(string)
}

variable "target_group_arn" {
  description = "The ARN of the target group"
  type        = string
}

variable "env_prefix" {
  description = "A prefix to use for naming resources"
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