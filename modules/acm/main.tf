#import aws certificate module
module "copebit_terraform_acm_test" {
  source                    = "terraform-aws-modules/acm/aws"
  version                   = "~> 5.0"
  domain_name               = var.domain_name
  zone_id                   = var.route53_zone_id
  validate_certificate      = true
  wait_for_validation       = true
  create_route53_records    = true
  validation_method         = "DNS"
}