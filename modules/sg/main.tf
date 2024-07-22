resource "aws_security_group" "jump_server_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.default_route] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-jump-server"
    }
  ) 
}

#Create security group for asg
resource "aws_security_group" "wordpressApp_sg" {
  vpc_id = var.vpc_id

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.jump_server_sg.id]
  }

  ingress {
    from_port   = 32768
    to_port     = 61000
    protocol    = "tcp"
    security_groups = [aws_security_group.wordpressApp_alb_sg.id]
    //cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    security_groups = [aws_security_group.wordpressApp_alb_sg.id]
    //cidr_blocks = [var.default_route]
  }

  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    security_groups = [aws_security_group.wordpressApp_alb_sg.id]
    //cidr_blocks = [var.default_route]
  }

  egress {
    from_port       = var.egress_port
    to_port         = var.egress_port
    protocol        = "-1"
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

#create security group for alb
resource "aws_security_group" "wordpressApp_alb_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.default_route]
  }

  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = [var.default_route]
  }

  egress {
    from_port       = var.egress_port
    to_port         = var.egress_port
    protocol        = "-1"
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

#create security group for rds
resource "aws_security_group" "rds_sg" {
  name        = var.rds_sg_name
  vpc_id      = var.vpc_id
  
  ingress {
    from_port   = var.db_sg_port
    to_port     = var.db_sg_port
    protocol    = "tcp"
    security_groups = [aws_security_group.wordpressApp_sg.id]
  }
  
  egress {
    from_port   = var.egress_port
    to_port     = var.egress_port
    protocol    = "-1"
    cidr_blocks = [var.default_route]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-rds-sg"
    }
  ) 
}
