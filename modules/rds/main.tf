resource "aws_db_instance" "wordpress_db" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  db_name              = var.db_name
  username             = var.db_user
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  publicly_accessible  = false
  vpc_security_group_ids = var.security_group_id
  db_subnet_group_name   = aws_db_subnet_group.main.name
  multi_az               = true
  skip_final_snapshot    = true
  final_snapshot_identifier = "final-snapshot-${local.timestamp}"
  
  tags = {
    Name = "${var.env_prefix}-db"
  }
}

locals {
  timestamp = formatdate("20060102150405", timestamp())
}

resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.env_prefix}-subnet-group"
  }
}

