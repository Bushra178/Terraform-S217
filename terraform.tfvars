#----------------General---------------------

vpc_cidr_block = "10.0.0.0/16"
avail_zone     = "us-east-1"
my_ip          = "116.90.115.23/32"
app_prefix     = "wordpress-app"
default_route  = "0.0.0.0/0"

tags = {
  app         = "wordpress"
  created-by  = "Bushra Fatima"
  environment = "XLDP-dev"
  project     = "S217-XLDP"
  owner       = "Bushra Fatima"
  team        = "Firebirds"
}

# -----------------ACM--------------------------

validate_certificate      = true
wait_for_validation       = false
create_route53_records    = true
validation_method         = "DNS"
subject_alternative_names = "fatima-wordpress"


#----------------ECS---------------------------

cluster_name          = "wordpress-ecs-cluster"
task_family           = "wordpress-task"
network_mode          = "awsvpc"
volume_name           = "ecs-wordpress-storage"
host_path             = "/ecs/ecs-wordpress-storage"
container_name        = "wordpress"
container_image       = "wordpress:latest"
container_memory      = 512
container_cpu         = 512
container_port        = 80
container_host_port   = 80
container_protocol    = "tcp"
container_essentials  = true
db_name               = "wordpressdb"
db_user               = "admin"
log_driver            = "awslogs"
logs_region           = "us-east-1"
logs_stream_prefix    = "wordpress"
ecs_service_name      = "wordpress-service"
service_launch_type   = "EC2"
service_desired_count = 3

#------------------Load Balancer--------------------

lb_name               = "wordppres-lb"
lb_internal           = false
lb_status_code        = "HTTP_301"
lb_type               = "application"
target_group_name     = "wordpress-app-target-group"
target_type           = "ip"
health_check_interval = 30
//health_check_path     = "/wp-admin/install.php"
health_check_path     = "/"
health_check_protocol = "HTTP"
health_check_timeout  = 25
healthy_threshold     = 2
unhealthy_threshold   = 5
http_port             = 80
http_protocol         = "HTTP"
https_port            = 443
https_protocol        = "HTTPS"
acm_ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"

#------------------------RDS-------------------------------------

db_identifier                = "wordpress-db"
db_allocated_storage         = 10
db_engine                    = "mysql"
db_instance_class            = "db.t3.micro"
db_param_group               = "default.mysql8.0"
db_storage_type              = "gp2"
db_subnet_name               = "main"
db_user_name                 = "admin"
db_skip_final_snapshot       = true
db_final_snapshot_identifier = "wordpress-snapshot"
pwd_length                   = 16
pwd_special                  = true
pwd_override_special         = "_!%^"
secret_name                  = "dbsss-seecret"

#----------------------Route53----------------------------

route53_type         = "A"
route53_health       = true
route53_private_zone = false
domain_name          = "xldp.xgrid.co"
route_zone_name      = "xldp.xgrid.co"
alb_record_name      = "fatima-wordpress"

#----------------------Security Group----------------------

egress_port = 0
db_sg_port  = 3306
rds_sg_name = "wordpress-rds-sg"

#---------------------Subnet-------------------------------

eip_domain          = "vpc"
map_public_ip       = true
subnet_cidr_block_1 = "10.0.1.0/24"
subnet_cidr_block_2 = "10.0.2.0/24"
subnet_cidr_block_3 = "10.0.3.0/24"
subnet_cidr_block_4 = "10.0.4.0/24"
az_1a               = "us-east-1a"
az_1b               = "us-east-1b"
image_name          = "amzn2-ami-ecs-hvm-2.0.20231211-x86_64-ebs"

#--------------------Auto Scaling Group---------------------

instance_type             = "t2.medium"
ssh_key_name              = "server-app-key"
launch_config_name        = "wordpress-app-launch-instance"
asg_name                  = "wordpress-ec2-autoscale"
asg_min_size              = 2
asg_max_size              = 2
asg_desired_capacity      = 2
health_check_type         = "ELB"
asg_health_check_period   = 300
propagate_at_launch       = true
scale_in_policy_name      = "scale-in"
scale_in_adjustment       = -1
scale_in_adjustment_type  = "ChangeInCapacity"
scale_in_cooldown         = 120
scale_out_policy_name     = "scale-out"
scale_out_adjustment      = 1
scale_out_adjustment_type = "ChangeInCapacity"
scale_out_cooldown        = 120
ssh_public_key_path       = "/home/xgrid/Documents/test-S217/id_rsa.pub"

#---------------------Cloudwatch---------------------------

log_group_name                  = "wordpress-app-log-groups"
high_cpu_alarm_name             = "high-cpu-utilization"
high_cpu_alarm_description      = "This metric monitors ec2 cpu utilization"
high_cpu_comparison_operator    = "GreaterThanThreshold"
high_cpu_evaluation_periods     = "2"
high_cpu_metric_name            = "CPUUtilization"
high_cpu_namespace              = "AWS/EC2"
high_cpu_period                 = "60"
high_cpu_statistics             = "Average"
high_cpu_threshold              = "40"
high_memory_alarm_name          = "high-memory-utilization"
high_memory_alarm_description   = "This metric monitors ec2 memory utilization"
high_memory_comparison_operator = "GreaterThanThreshold"
high_memory_evaluation_periods  = "2"
high_memory_metric_name         = "MemoryUtilization"
high_memory_namespace           = "System/Linux"
high_memory_period              = "60"
high_memory_statistics          = "Average"
high_memory_threshold           = "60"
low_cpu_alarm_name              = "LowCPUUtilization"
low_cpu_alarm_description       = "This alarm triggers if CPU utilization is less than 20% for 2 consecutive periods."
low_cpu_comparison_operator     = "LessThanThreshold"
low_cpu_evaluation_periods      = "2"
low_cpu_metric_name             = "CPUUtilization"
low_cpu_namespace               = "AWS/EC2"
low_cpu_period                  = "120"
low_cpu_statistics              = "Average"
low_cpu_threshold               = "20"
low_memory_alarm_name           = "LowMemoryUtilization"
low_memory_alarm_description    = "This alarm triggers if memory utilization is less than 30% for 2 consecutive periods."
low_memory_comparison_operator  = "LessThanThreshold"
low_memory_evaluation_periods   = "2"
low_memory_metric_name          = "MemoryUtilization"
low_memory_namespace            = "CWAgent"
low_memory_period               = "120"
low_memory_statistics           = "Average"
low_memory_threshold            = "30"
