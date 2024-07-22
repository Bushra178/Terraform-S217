#Get Linux image id
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

#Create key pair for EC2
resource "aws_key_pair" "ssh_key" {
  key_name = var.ssh_key_name
  public_key = file(var.ssh_public_key_path)
}

# Define the launch configuration
resource "aws_launch_configuration" "wordpress_app_launch_config" {
  name          = var.launch_config_name
  image_id      = data.aws_ami.latest_aws_linux_image.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh_key.key_name
  iam_instance_profile = var.ecs_instance_profile
  associate_public_ip_address = true
  security_groups = [var.asg_sg_id]
  user_data = base64encode(templatefile(
    "${path.root}/user-data.sh",
    { cluster_name = var.ecs_cluster_name }
  ))
}  

# Define the Auto Scaling Group
resource "aws_autoscaling_group" "ec2_autoscaling_group" {
  name                 = var.asg_name
  launch_configuration = aws_launch_configuration.wordpress_app_launch_config.name
  min_size             = var.asg_min_size
  max_size             = var.asg_max_size
  desired_capacity     = var.asg_desired_capacity
  vpc_zone_identifier  = var.private_subnet_ids
  
  # Ensure Auto Scaling Group waits for instances to be InService before marking ASG creation complete
  health_check_type          = var.health_check_type
  health_check_grace_period  = var.asg_health_check_period

  lifecycle {
    create_before_destroy = true
  }

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

 resource "aws_instance" "bastion_host" {
  ami                    = "ami-020ce7b4a10644f12" 
  instance_type          = "t2.micro"     
  key_name               = aws_key_pair.ssh_key.key_name 
  subnet_id              = var.public_subnet_ids
  associate_public_ip_address = true       
  security_groups        = [var.jum_sg_id]

  tags = {
    Name = "BastionHost"
  }
}
