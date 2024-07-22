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

variable "route53_private_zone" {
  description = "Name or ID of the private Route 53 hosted zone"
  type        = string
}

variable "route53_type" {
  description = "Type of Route 53 record (e.g., A, CNAME, Alias)"
  type        = string
}

variable "route53_health" {
  description = "Health check configuration for Route 53 records (optional)"
  type        = bool
}
