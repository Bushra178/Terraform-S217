variable "avail_zone" {
  description = "The availability zone to be used"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group"
  type        = list(string)
}

variable "env_prefix" {
  description = "A prefix to use for naming resources"
  type        = string
}

variable "subnet_cidr_block_1" {
  description = "CIDR block for the first subnet"
  type        = string
}

variable "subnet_cidr_block_2" {
  description = "CIDR block for the second subnet"
  type        = string
}

variable "subnet_cidr_block_3" {
  description = "CIDR block for the third subnet"
  type        = string
}

variable "subnet_cidr_block_4" {
  description = "CIDR block for the fourth subnet"
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