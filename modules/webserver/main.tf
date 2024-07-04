# Get linux image Id for EC2 Instance
data "aws_ami" "latest_aws_linux_image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = [var.image_name]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

# Define the launch configuration
resource "aws_launch_configuration" "wordpress_launch_config" {
  name          = var.launch_config_name
  image_id      = data.aws_ami.latest_aws_linux_image.id
  instance_type = var.instance_type
  iam_instance_profile = var.iam_instance_profile
  security_groups = [var.asg_sg]

  user_data                   = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config
EOF
}  

# Define the Auto Scaling Group
resource "aws_autoscaling_group" "ec2_autoscaling_group" {
  name                 = var.autoscaling_group_name
  launch_configuration = aws_launch_configuration.wordpress_launch_config.name
  min_size             = var.asg_min_size
  max_size             = var.asg_max_size
  desired_capacity     = var.asg_desired_capacity
  vpc_zone_identifier  = var.private_subnet_ids  
  target_group_arns = [var.asg_target_group_arn]

  # Enable instance protection from scale in
  protect_from_scale_in = var.scale_in_protection
  
  # Ensure Auto Scaling Group waits for instances to be InService before marking ASG creation complete
  health_check_type          = var.asg_health_check_type
  health_check_grace_period  = var.asg_health_check_grace_period

  tag {
    key                 = "Name"
    value               = "${var.app_prefix}-asg"
    propagate_at_launch = var.propagate_at_launch
  }
}

# Scaling policy for scaling out
resource "aws_autoscaling_policy" "scale_out_policy" {
  name                   = var.scale_out_policy_name
  scaling_adjustment     = var.scale_out_adjustment
  adjustment_type        = var.scale_out_adjustment_type
  cooldown               = var.scale_out_cooldown
  autoscaling_group_name = aws_autoscaling_group.ec2_autoscaling_group.name
}

# Scaling policy for scaling in
resource "aws_autoscaling_policy" "scale_in_policy" {
  name                   = var.scale_in_policy_name
  scaling_adjustment     = var.scale_in_adjustment
  adjustment_type        = var.scale_in_adjustment_type
  cooldown               = var.scale_in_cooldown
  autoscaling_group_name = aws_autoscaling_group.ec2_autoscaling_group.name
}

