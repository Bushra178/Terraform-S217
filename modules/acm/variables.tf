variable "route53_zone_id" {
  description = "The ID of the Route 53 hosted zone"
  type        = string
}

variable "domain_name" {
  description = "The domain name to use for Route 53"
  type        = string
}

variable "validate_certificate" {
  description = "Whether to validate the SSL certificate. Set to true to perform validation."
  type        = bool
}

variable "wait_for_validation" {
  description = "Whether to wait for the certificate validation to complete. Set to true to wait for validation."
  type        = bool
}

variable "create_route53_records" {
  description = "Whether to create Route53 DNS records for the certificate validation. Set to true to create the records."
  type        = bool
}

variable "validation_method" {
  description = "The method to use for validating the certificate. Typically 'DNS' or 'EMAIL'."
  type        = string
}

variable "subject_alternative_names" {
  description = "A list of additional domains (subject alternative names) to be included in the SSL certificate."
  type        = string
}
