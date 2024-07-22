variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "image_name" {
  description = "The name of the AMI to use for instances"
  type        = string
}

variable "avail_zone" {
  description = "The availability zone to be used"
  type        = string
}

variable "my_ip" {
  description = "The IP address of the user"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for EC2 instances"
  type        = string
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs"
  type        = list(string)
}

variable "app_prefix" {
  description = "A prefix to use for naming resources"
  type        = string
}

variable "default_route" {
  description = "The default route for the route table"
  type        = string
}

variable "ssh_public_key_path" {
  description = "The path to the SSH public key file"
  type        = string
}

variable "public_subnet_ids" {
  description = "The path to the SSH public key file"
  type        = string
}

variable "asg_sg_id" {
  description = "The path to the SSH public key file"
  type        = string
}

variable "ecs_cluster_name" {
  description = "The path to the SSH public key file"
  type        = string
}

variable "ecs_instance_profile" {
  description = "The path to the SSH public key file"
  type        = string
}

variable jum_sg_id {}

variable "ssh_key_name" {
  description = "Name of the SSH key pair used to access instances"
  type        = string
}

variable "launch_config_name" {
  description = "Name of the EC2 launch configuration"
  type        = string
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group (ASG)"
  type        = string
}

variable "asg_min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
}

variable "asg_max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
}

variable "health_check_type" {
  description = "Type of health check for instances in the Auto Scaling Group (EC2 or ELB)"
  type        = string
}

variable "asg_health_check_period" {
  description = "Time (in seconds) between health checks for instances in the Auto Scaling Group"
  type        = number
}

variable "propagate_at_launch" {
  description = "Whether instances inherit security group and subnet attributes from ASG"
  type        = bool
}

variable "scale_out_policy_name" {
  description = "Name of the scale out policy for the Auto Scaling Group"
  type        = string
}

variable "scale_in_policy_name" {
  description = "Name of the scale in policy for the Auto Scaling Group"
  type        = string
}

variable "scale_out_adjustment" {
  description = "Number of instances to add when scaling out"
  type        = number
}

variable "scale_in_adjustment" {
  description = "Number of instances to remove when scaling in"
  type        = number
}

variable "scale_out_adjustment_type" {
  description = "Type of adjustment for scale out (ChangeInCapacity, ExactCapacity, PercentChangeInCapacity)"
  type        = string
}

variable "scale_in_adjustment_type" {
  description = "Type of adjustment for scale in (ChangeInCapacity, ExactCapacity, PercentChangeInCapacity)"
  type        = string
}

variable "scale_out_cooldown" {
  description = "Cooldown period (in seconds) for scaling out activities"
  type        = number
}

variable "scale_in_cooldown" {
  description = "Cooldown period (in seconds) for scaling in activities"
  type        = number
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}
