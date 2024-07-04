# Create security group for Auto Scaling Group
resource "aws_security_group" "wordpressApp_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = var.ingress_protocol
    cidr_blocks = [var.vpc_cidr_block]
  }

  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = var.ingress_protocol
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = var.egress_protocol
    cidr_blocks     = [var.default_route]
    prefix_list_ids = []
  }

   tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-asg-sg"
    }
  )
}

# Create security group for Load Balancer
resource "aws_security_group" "wordpressApp_alb_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = var.ingress_protocol
    cidr_blocks = [var.default_route]
  }

  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = var.ingress_protocol
    cidr_blocks = [var.default_route]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = var.egress_protocol
    cidr_blocks     = [var.default_route]
    prefix_list_ids = []
  }

   tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-alb-sg"
    }
  )
}

# Create security group for db Instance
resource "aws_security_group" "rds_sg" {
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.wordpress_port
    to_port         = var.wordpress_port
    protocol        = var.ingress_protocol
    security_groups = [aws_security_group.wordpressApp_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = var.egress_protocol
    cidr_blocks = [var.default_route]
  }

   tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-db-sg"
    }
  )
}


