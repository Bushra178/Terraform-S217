resource "aws_security_group" "wordpressApp_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "${var.env_prefix}-sg"
  }
}

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

output "aws_ami_id" {
  value = data.aws_ami.latest_aws_linux_image.id
}

resource "aws_key_pair" "ssh-key" {
  key_name = "server-key"
  public_key = file("/home/xgrid/Documents/bushrafatima/id_rsa.pub")
}


# Define the launch configuration
resource "aws_launch_configuration" "wordpress_launch_config" {
  name          = "wordpress-app-launch-instance"
  image_id      = data.aws_ami.latest_aws_linux_image.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh-key.key_name
  associate_public_ip_address = true
  security_groups = [aws_security_group.wordpressApp_sg.id]
  user_data = filebase64("/home/xgrid/Documents/bushrafatima/user-data.sh")
}  

# Define the Auto Scaling Group
resource "aws_autoscaling_group" "ec2_autoscaling_group" {
  name                 = "wordpress-ec2-autoscale"
  launch_configuration = aws_launch_configuration.wordpress_launch_config.name
  min_size             = 2
  max_size             = 6
  desired_capacity     = 4
  vpc_zone_identifier  = var.private_subnet_ids  
  target_group_arns = [var.target_group_arn]
  
  # Ensure Auto Scaling Group waits for instances to be InService before marking ASG creation complete
  health_check_type          = "ELB"
  health_check_grace_period  = 300

  tag {
    key                 = "Name"
    value               = "${var.env_prefix}-asg"
    propagate_at_launch = true
  }
}

# Scaling policy for scaling out
resource "aws_autoscaling_policy" "scale_out_policy" {
  name                   = "scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 120
  autoscaling_group_name = aws_autoscaling_group.ec2_autoscaling_group.name
}

# Scaling policy for scaling in
resource "aws_autoscaling_policy" "scale_in_policy" {
  name                   = "scale-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 120
  autoscaling_group_name = aws_autoscaling_group.ec2_autoscaling_group.name
}






