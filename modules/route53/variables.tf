variable "lb_zone_id" {
  description = "The Zone ID for the load balancer"
  type        = string
}

variable "lb_dns_name" {
  description = "The DNS name for the load balancer"
  type        = string
}

variable "route_zone_name" {
  description = "The Route 53 hosted zone name"
  type        = string
}

variable "alb_record_name" {
  description = "The record name for the Application Load Balancer in Route 53"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}

variable private_zone {}
variable record_type {}
variable evaluate_target_health {}

