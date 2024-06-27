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

variable "env_prefix" {
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