variable "app_prefix" {
  description = "Prefix to use for environment resources"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "default_route" {
  description = "The default route for the route table"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}

variable http_port {}
variable https_port {}
variable ingress_protocol {}
variable egress_protocol {}
variable wordpress_port {}




