module "copebit_terraform_acm_test" {
  source                    = "terraform-aws-modules/acm/aws"
  version                   = "~> 5.0"
  domain_name               = "fatima.xldp.xgrid.co"
  zone_id                   = var.route53_zone_id
  validate_certificate      = true
  wait_for_validation       = true
  create_route53_records    = true
  validation_method         = "DNS"
}

# resource "aws_acm_certificate" "app_certificate" {
#   domain_name       = "fatima-wp-app.xgrid.co"
#   validation_method = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }

#   tags = {
#     Name = "${var.env_prefix}-acm-certificate"
#   }
# }

# resource "aws_acm_certificate_validation" "wordpress_dns_validation" {
#   certificate_arn         = aws_acm_certificate.app_certificate.arn
#   validation_record_fqdns = [for record in aws_route53_record.app_certificate_validation : record.fqdn]

#   timeouts {
#     create = "30m"
#   }
# }