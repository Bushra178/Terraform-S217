variable "route53_zone_id" {
  description = "ID of the Route 53 hosted zone where DNS records will be managed."
  type        = string
}

variable "domain_name" {
  description = "Domain name associated with application."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}

variable app_prefix {}

variable certificate_validation {}

variable wait_for_validation {}

variable route53_record_creation {}

variable method_for_validation {}

variable alternative_domain_name {}



