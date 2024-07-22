#import aws certificate module
module "acm_certificate" {
  source                    = "terraform-aws-modules/acm/aws"
  version                   = "~> 5.0"
  domain_name               = var.domain_name
  zone_id                   = var.route53_zone_id
  validate_certificate      = var.validate_certificate
  wait_for_validation       = var.wait_for_validation
  create_route53_records    = var.create_route53_records
  validation_method         = var.validation_method
  subject_alternative_names =  ["${var.subject_alternative_names}.${var.domain_name}"]
}
