#create vpc
resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-vpc"
    }
  )
}

resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

# Create the Secret in AWS Secrets Manager
resource "aws_secretsmanager_secret" "db_creds_secret" {
  name = "wordpress-app-creds"

  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-db-secret"
    }
  )
}

resource "aws_secretsmanager_secret_version" "db_creds_version" {
  secret_id     = aws_secretsmanager_secret.db_creds_secret.id
  secret_string = random_password.rds_password.result
}

# output "depends_on_secret_version" {
#   value = [aws_secretsmanager_secret_version.db_creds]
# }

# data "aws_secretsmanager_secret_version" "db_creds" {
#   secret_id = aws_secretsmanager_secret.db_creds.id
# }

# locals {
#   db_creds = jsondecode(data.aws_secretsmanager_secret_version.db_creds.secret_string)
# }

#include all modules in root file and pass variables
module "subnet_module" {
  source              = "./modules/subnet"
  avail_zone          = var.avail_zone
  vpc_id              = aws_vpc.app_vpc.id
  security_group_id   = module.sg.asg_sg
  app_prefix          = var.app_prefix
  default_route       = var.default_route
  subnet_cidr_block_1 = var.subnet_cidr_block_1
  subnet_cidr_block_2 = var.subnet_cidr_block_2
  subnet_cidr_block_3 = var.subnet_cidr_block_3
  subnet_cidr_block_4 = var.subnet_cidr_block_4
  az_1a               = var.az_1a
  az_1b               = var.az_1b
  tags                = var.tags
}

module "aws_instance" {
  source                        = "./modules/webserver"
  vpc_id                        = aws_vpc.app_vpc.id
  private_subnet_ids            = module.subnet_module.private_subnet_ids
  avail_zone                    = var.avail_zone
  instance_type                 = var.instance_type
  image_name                    = var.image_name
  my_ip                         = var.my_ip
  asg_target_group_arn          = module.alb.asg_target_group_arn
  app_prefix                    = var.app_prefix
  iam_instance_profile          = module.aws_iam.iam_instance_profile
  ecs_cluster_name              = module.aws_ecs.ecs_cluster_name
  asg_sg                        = module.sg.asg_sg
  autoscaling_group_name        = var.autoscaling_group_name
  asg_health_check_type         = var.asg_health_check_type
  asg_health_check_grace_period = var.asg_health_check_grace_period
  launch_config_name            = var.launch_config_name
  asg_min_size                  = var.asg_min_size
  asg_max_size                  = var.asg_max_size
  propagate_at_launch           = var.propagate_at_launch
  asg_desired_capacity          = var.asg_desired_capacity
  scale_in_policy_name          = var.scale_in_policy_name
  scale_in_adjustment           = var.scale_in_adjustment
  scale_in_adjustment_type      = var.scale_in_adjustment_type
  scale_in_cooldown             = var.scale_in_cooldown
  scale_in_protection           = var.scale_in_protection
  scale_out_policy_name         = var.scale_out_policy_name
  scale_out_adjustment          = var.scale_out_adjustment
  scale_out_adjustment_type     = var.scale_in_adjustment_type
  scale_out_cooldown            = var.scale_in_cooldown
  tags                          = var.tags
}

module "alb" {
  source                  = "./modules/loadbalancer"
  vpc_id                  = aws_vpc.app_vpc.id
  public_subnet_ids       = module.subnet_module.public_subnet_ids
  app_prefix              = var.app_prefix
  certificate_arn         = module.cert_module.certificate_arn
  alb_sg                  = module.sg.alb_sg
  acm_ssl_policy          = var.acm_ssl_policy
  redirect_port           = var.redirect_port
  redirect_protocol       = var.redirect_protocol
  target_group_name       = var.target_group_name
  target_group_port       = var.target_group_port
  target_group_protocol   = var.target_group_protocol
  target_type             = var.target_type
  health_check_path       = var.health_check_path
  health_check_intervel   = var.health_check_intervel
  health_check_protocol   = var.health_check_protocol
  health_check_timeout    = var.health_check_timeout
  healthy_threshold       = var.healthy_threshold
  unhealthy_threshold     = var.unhealthy_threshold
  https_action_type       = var.https_action_type
  https_listener_port     = var.https_listener_port
  https_listener_protocol = var.https_listener_protocol
  lb_name                 = var.lb_name
  lb_type                 = var.lb_type
  listener_port           = var.listener_port
  listener_protocol       = var.listener_protocol
  action_type             = var.action_type
  status_code             = var.status_code
  tags                    = var.tags
}

module "route_53" {
  source                 = "./modules/route53"
  lb_zone_id             = module.alb.lb_zone_id
  lb_dns_name            = module.alb.lb_dns_name
  route_zone_name        = var.route_zone_name
  alb_record_name        = var.alb_record_name
  private_zone           = var.private_zone
  evaluate_target_health = var.evaluate_target_health
  record_type            = var.record_type
  tags                   = var.tags
}

module "cert_module" {
  source                  = "./modules/acm"
  route53_zone_id         = module.route_53.route53_zone_id
  domain_name             = var.domain_name
  wait_for_validation     = var.wait_for_validation
  method_for_validation   = var.method_for_validation
  route53_record_creation = var.route53_record_creation
  certificate_validation  = var.certificate_validation
  alternative_domain_name = var.alternative_domain_name
  app_prefix              = var.app_prefix
  tags                    = var.tags
}

module "cloudwatch_alarm" {
  source                 = "./modules/cloudwatch"
  autoscaling_group_name = module.aws_instance.autoscaling_group_name
  scale_out_policy_arn   = module.aws_instance.scale_out_policy_arn
  scale_in_policy_arn    = module.aws_instance.scale_in_policy_arn
  ecs_cluster_name       = module.aws_ecs.ecs_cluster_name
  ecs_service_name       = module.aws_ecs.ecs_service_name
}

module "aws_rds" {
  source                    = "./modules/rds"
  db_name                   = var.db_name
  db_user                   = var.db_user
  db_password               = aws_secretsmanager_secret_version.db_creds_version.secret_string
  private_subnet_ids        = module.subnet_module.private_subnet_ids
  app_prefix                = var.app_prefix
  rds_sg                    = module.sg.rds_sg
  db_allocated_storage      = var.db_allocated_storage
  db_engine                 = var.db_engine
  db_identifier             = var.db_identifier
  db_instance_class         = var.db_instance_class
  db_parameter_group_name   = var.db_parameter_group_name
  db_storage_type           = var.db_storage_type
  skip_final_snapshot       = var.skip_final_snapshot
  subnet_group_name         = var.subnet_group_name
  publicly_accessible       = var.publicly_accessible
  multi_az                  = var.multi_az
  final_snapshot_identifier = var.final_snapshot_identifier
  tags                      = var.tags
  // dependency = [aws_secretsmanager_secret_version.db_creds]
}

module "aws_ecs" {
  source                   = "./modules/ecs"
  wordpress_image_name     = var.wordpress_image_name
  db_name                  = var.db_name
  db_user                  = var.db_user
  db_password              = aws_secretsmanager_secret_version.db_creds_version.secret_string
  db_address               = module.aws_rds.db_address
  public_subnet_ids        = module.subnet_module.public_subnet_ids
  ecs_target_group_arn     = module.alb.asg_target_group_arn
  security_group_id        = module.sg.asg_sg
  app_prefix               = var.app_prefix
  autoscaling_group_arn    = module.aws_instance.autoscaling_group_arn
  ecs_task_role            = module.aws_iam.ecs_task_role
  container_volume         = var.container_volume
  container_volume_path    = var.container_volume_path
  ecs_family               = var.ecs_family
  ecs_cpu_architecture     = var.ecs_cpu_architecture
  //ecs_network_mode         = var.ecs_network_mode
  ecs_os                   = var.ecs_os
  tags                     = var.tags
  container_name           = var.container_name
  container_cpu            = var.container_cpu
  container_memory         = var.container_memory
  container_port           = var.container_port
  log_driver               = var.log_driver
  log_group                = var.log_group
  log_group_name           = var.log_group_name
  logs_prefix              = var.logs_prefix
  logs_region              = var.logs_region
  lb_container_name        = var.lb_container_name
  lb_container_port        = var.lb_container_port
  scaling_status           = var.scaling_status
  ecs_cluster_name         = var.ecs_cluster_name
  ecs_provider_name        = var.ecs_provider_name
  target_capacity          = var.target_capacity
  max_scaling_step_size    = var.max_scaling_step_size
  min_scaling_step_size    = var.min_scaling_step_size
  termination_protection   = var.termination_protection
  ecs_service_name         = var.ecs_service_name
  service_count            = var.service_count
  capacity_provider_weight = var.capacity_provider_weight
  capacity_provider_base   = var.capacity_provider_base
  container_protocol       = var.container_protocol
  log_group_retention      = var.log_group_retention
  host_port                = var.host_port
  //dependency = [aws_secretsmanager_secret_version.db_creds]
}

module "aws_iam" {
  source = "./modules/iam"
}

module "sg" {
  source           = "./modules/securitygroup"
  vpc_id           = aws_vpc.app_vpc.id
  app_prefix       = var.app_prefix
  vpc_cidr_block   = var.vpc_cidr_block
  default_route    = var.default_route
  http_port        = var.http_port
  https_port       = var.https_port
  wordpress_port   = var.wordpress_port
  egress_protocol  = var.egress_protocol
  ingress_protocol = var.ingress_protocol
  tags             = var.tags
}

