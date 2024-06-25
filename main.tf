#create vpc
resource "aws_vpc" "app-vpc" {
    cidr_block = var.vpc_cidr_block

    tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

#include subnet module
module "subnet_module" {
    source = "./modules/subnet"
    avail_zone = var.avail_zone
    vpc_id = aws_vpc.app-vpc.id
    security_group_id = module.aws_instance.security_group_id
    env_prefix = var.env_prefix
}

module "aws_instance" {
    source = "./modules/webserver"   
    vpc_id = aws_vpc.app-vpc.id
    private_subnet_ids = module.subnet_module.private_subnet_ids
    avail_zone = var.avail_zone
    instance_type = var.instance_type
    image_name = var.image_name
    my_ip = var.my_ip
    target_group_arn = module.alb.lb_target_group_arn
    env_prefix = var.env_prefix
}   

module "alb" {
    source = "./modules/loadbalancer"
    vpc_id = aws_vpc.app-vpc.id
    security_group_id = module.aws_instance.security_group_id
    public_subnet_ids = module.subnet_module.public_subnet_ids
    env_prefix = var.env_prefix
    certificate_arn = module.cert_module.certificate_arn
}

module "route_53" {
    source = "./modules/route53"
    lb_zone_id = module.alb.lb_zone_id
    lb_dns_name = module.alb.lb_dns_name
}

module "cert_module" {
    source = "./modules/acm"
    route53_zone_id = module.route_53.route53_zone_id
}

module "cloudwatch_alarm" {
    source = "./modules/cloudwatch"
    autoscaling_group_name = module.aws_instance.autoscaling_group_name
    scale_out_policy_arn = module.aws_instance.scale_out_policy_arn
    scale_in_policy_arn = module.aws_instance.scale_in_policy_arn
}