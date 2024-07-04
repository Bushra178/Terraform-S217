#import aws certificate module
module "copebit_terraform_acm_test" {
  source                    = "terraform-aws-modules/acm/aws"
  version                   = "~> 5.0"
  domain_name               = var.domain_name
  zone_id                   = var.route53_zone_id
  validate_certificate      = var.certificate_validation
  wait_for_validation       = var.wait_for_validation
  create_route53_records    = var.route53_record_creation
  validation_method         = var.method_for_validation
  subject_alternative_names =  ["${var.alternative_domain_name}.${var.domain_name}"]
  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-certificate"
    }
  ) 
}



