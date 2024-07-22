#terraform remote backend configuration 
# terraform {
#   backend "s3" {
#     bucket         = "wordpress-state-bucket"
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "wordpress-statelock-table"
#   }
# }

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

#include modules in root file and pass parameters
module "subnet_module" {
  source              = "./modules/subnet"
  avail_zone          = var.avail_zone
  vpc_id              = aws_vpc.app_vpc.id
  app_prefix          = var.app_prefix
  subnet_cidr_block_1 = var.subnet_cidr_block_1
  subnet_cidr_block_2 = var.subnet_cidr_block_2
  subnet_cidr_block_3 = var.subnet_cidr_block_3
  subnet_cidr_block_4 = var.subnet_cidr_block_4
  az_1a               = var.az_1a
  az_1b               = var.az_1b
  default_route       = var.default_route
  map_public_ip       = var.map_public_ip
  eip_domain          = var.eip_domain
  tags                = var.tags
}

module "aws_instance" {
  source                    = "./modules/webserver"
  vpc_id                    = aws_vpc.app_vpc.id
  private_subnet_ids        = module.subnet_module.private_subnet_ids
  avail_zone                = var.avail_zone
  instance_type             = var.instance_type
  image_name                = var.image_name
  my_ip                     = var.my_ip
  app_prefix                = var.app_prefix
  default_route             = var.default_route
  ssh_public_key_path       = var.ssh_public_key_path
  public_subnet_ids         = module.subnet_module.public_sub_ip
  asg_sg_id                 = module.sg.asg_sg_id
  ecs_cluster_name          = module.ecs.ecs_cluster_name
  ecs_instance_profile      = module.iam.ecs_instance_profile
  jum_sg_id                 = module.sg.jum_sg_id
  launch_config_name        = var.launch_config_name
  asg_name                  = var.asg_name
  asg_min_size              = var.asg_min_size
  asg_max_size              = var.asg_max_size
  asg_desired_capacity      = var.asg_desired_capacity
  asg_health_check_period   = var.asg_health_check_period
  scale_in_policy_name      = var.scale_in_policy_name
  scale_in_adjustment       = var.scale_in_adjustment
  scale_in_adjustment_type  = var.scale_in_adjustment_type
  scale_in_cooldown         = var.scale_in_cooldown
  scale_out_policy_name     = var.scale_out_policy_name
  scale_out_adjustment      = var.scale_out_adjustment
  scale_out_adjustment_type = var.scale_out_adjustment_type
  scale_out_cooldown        = var.scale_out_cooldown
  health_check_type         = var.health_check_type
  propagate_at_launch       = var.propagate_at_launch
  ssh_key_name              = var.ssh_key_name
  tags                      = var.tags
}

module "ecs" {
  source                = "./modules/ecs"
  cluster_name          = var.cluster_name
  lb_target_group_arn   = module.alb.lb_target_group_arn
  ecs_service_role      = module.iam.ecs_service_role
  ecs_task_role         = module.iam.ecs_task_role
  task_execution_role   = module.iam.task_execution_role
  db_endpoint           = module.rds.db_endpoint
  db_password           = module.rds.db_password
  log_group_name        = module.cloudwatch_alarm.log_group_name
  task_family           = var.task_family
  container_name        = var.container_name
  container_image       = var.container_image
  container_essentials  = var.container_essentials
  container_cpu         = var.container_cpu
  container_memory      = var.container_memory
  container_port        = var.container_port
  container_protocol    = var.container_protocol
  container_host_port   = var.container_host_port
  service_desired_count = var.service_desired_count
  service_launch_type   = var.service_launch_type
  host_path             = var.host_path
  network_mode          = var.network_mode
  db_name               = var.db_name
  db_user               = var.db_user
  log_driver            = var.log_driver
  logs_region           = var.logs_region
  logs_stream_prefix    = var.logs_stream_prefix
  volume_name           = var.volume_name
  ecs_service_name      = var.ecs_service_name
  app_prefix            = var.app_prefix
  secret_policy_arn     = module.rds.secret_policy_arn
  private_subnet_ids    = module.subnet_module.private_subnet_ids
  sg_id                 = module.sg.asg_sg_id
  tags                  = var.tags
}

module "rds" {
  source                       = "./modules/rds"
  private_subnet_ids           = module.subnet_module.private_subnet_ids
  rds_sg_id                    = module.sg.rds_sg_id
  db_allocated_storage         = var.db_allocated_storage
  db_engine                    = var.db_engine
  db_identifier                = var.db_identifier
  db_skip_final_snapshot       = var.db_skip_final_snapshot
  db_final_snapshot_identifier = var.db_final_snapshot_identifier
  db_instance_class            = var.db_instance_class
  db_name                      = var.db_name
  db_user_name                 = var.db_user
  db_param_group               = var.db_param_group
  db_storage_type              = var.db_storage_type
  db_subnet_name               = var.db_subnet_name
  pwd_length                   = var.pwd_length
  pwd_override_special         = var.pwd_override_special
  pwd_special                  = var.pwd_special
  secret_name                  = var.secret_name
  app_prefix                   = var.app_prefix
  tags                         = var.tags
}

module "iam" {
  source            = "./modules/iam"
  secret_policy_arn = module.rds.secret_policy_arn
  db_arn            = module.rds.db_arn
  asg_arn           = module.aws_instance.asg_arn
  s3_bucket_arn     = module.backend.s3_bucket_arn
  dynamodb_arn      = module.backend.dynamodb_arn
}

module "alb" {
  source                = "./modules/loadbalancer"
  vpc_id                = aws_vpc.app_vpc.id
  security_group_id     = module.sg.alb_sg_id
  public_subnet_ids     = module.subnet_module.public_subnet_ids
  app_prefix            = var.app_prefix
  certificate_arn       = module.cert_module.certificate_arn
  http_port             = var.http_port
  http_protocol         = var.http_protocol
  https_port            = var.https_port
  https_protocol        = var.https_protocol
  health_check_interval = var.health_check_interval
  health_check_path     = var.health_check_path
  health_check_protocol = var.health_check_protocol
  health_check_timeout  = var.health_check_timeout
  healthy_threshold     = var.healthy_threshold
  unhealthy_threshold   = var.unhealthy_threshold
  target_group_name     = var.target_group_name
  target_type           = var.target_type
  lb_name               = var.lb_name
  lb_internal           = var.lb_internal
  lb_status_code        = var.lb_status_code
  lb_type               = var.lb_type
  acm_ssl_policy        = var.acm_ssl_policy
  record_name           = module.route_53.record_name
  tags                  = var.tags
}

module "route_53" {
  source               = "./modules/route53"
  lb_zone_id           = module.alb.lb_zone_id
  lb_dns_name          = module.alb.lb_dns_name
  alb_record_name      = var.alb_record_name
  route_zone_name      = var.route_zone_name
  route53_type         = var.route53_type
  route53_health       = var.route53_health
  route53_private_zone = var.route53_private_zone
}

module "cert_module" {
  source                    = "./modules/acm"
  route53_zone_id           = module.route_53.route53_zone_id
  domain_name               = var.domain_name
  validate_certificate      = var.validate_certificate
  validation_method         = var.validation_method
  subject_alternative_names = var.subject_alternative_names
  wait_for_validation       = var.wait_for_validation
  create_route53_records    = var.create_route53_records
}

module "cloudwatch_alarm" {
  source                          = "./modules/cloudwatch"
  autoscaling_group_name          = module.aws_instance.autoscaling_group_name
  scale_out_policy_arn            = module.aws_instance.scale_out_policy_arn
  scale_in_policy_arn             = module.aws_instance.scale_in_policy_arn
  ecs_cluster_name                = module.ecs.ecs_cluster_name
  ecs_service_name                = module.ecs.ecs_service_name
  log_group_name                  = var.log_group_name
  high_cpu_alarm_name             = var.high_cpu_alarm_name
  high_cpu_alarm_description      = var.high_cpu_alarm_description
  high_cpu_comparison_operator    = var.high_cpu_comparison_operator
  high_cpu_evaluation_periods     = var.high_cpu_evaluation_periods
  high_cpu_metric_name            = var.high_cpu_metric_name
  high_cpu_namespace              = var.high_cpu_namespace
  high_cpu_period                 = var.high_cpu_period
  high_cpu_statistics             = var.high_cpu_statistics
  high_cpu_threshold              = var.high_cpu_threshold
  high_memory_alarm_name          = var.high_memory_alarm_name
  high_memory_comparison_operator = var.high_memory_comparison_operator
  high_memory_evaluation_periods  = var.high_memory_evaluation_periods
  high_memory_metric_name         = var.high_memory_metric_name
  high_memory_namespace           = var.high_memory_namespace
  high_memory_period              = var.high_memory_period
  high_memory_statistics          = var.high_memory_statistics
  high_memory_threshold           = var.high_memory_threshold
  high_memory_alarm_description   = var.high_memory_alarm_description
  low_cpu_alarm_name              = var.low_cpu_alarm_name
  low_cpu_comparison_operator     = var.low_cpu_comparison_operator
  low_cpu_evaluation_periods      = var.low_cpu_evaluation_periods
  low_cpu_metric_name             = var.low_cpu_metric_name
  low_cpu_namespace               = var.low_cpu_namespace
  low_cpu_period                  = var.low_cpu_period
  low_cpu_statistics              = var.low_cpu_statistics
  low_cpu_threshold               = var.low_cpu_threshold
  low_cpu_alarm_description       = var.low_cpu_alarm_description
  low_memory_alarm_name           = var.low_memory_alarm_name
  low_memory_comparison_operator  = var.low_memory_comparison_operator
  low_memory_evaluation_periods   = var.low_memory_evaluation_periods
  low_memory_metric_name          = var.low_memory_metric_name
  low_memory_namespace            = var.low_memory_namespace
  low_memory_period               = var.low_memory_period
  low_memory_statistics           = var.low_memory_statistics
  low_memory_threshold            = var.low_memory_threshold
  low_memory_alarm_description    = var.low_memory_alarm_description
}

module "sg" {
  source         = "./modules/sg"
  vpc_cidr_block = var.vpc_cidr_block
  app_prefix     = var.app_prefix
  default_route  = var.default_route
  vpc_id         = aws_vpc.app_vpc.id
  my_ip          = var.my_ip
  http_port      = var.http_port
  https_port     = var.https_port
  egress_port    = var.egress_port
  db_sg_port     = var.db_sg_port
  rds_sg_name    = var.rds_sg_name
  tags           = var.tags
}

module "backend" {
  source     = "./modules/backend"
  app_prefix = var.app_prefix
  tags       = var.tags
}