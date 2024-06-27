variable "lb_zone_id" {
  description = "The ID of the Route 53 hosted zone containing the load balancer"
  type        = string
}

variable "lb_dns_name" {
  description = "The DNS name of the load balancer"
  type        = string
}

variable "route_zone_name" {
  description = "The name of the Route 53 hosted zone"
  type        = string
}

variable "alb_record_name" {
  description = "The name of the Route 53 record for the ALB"
  type        = string
}