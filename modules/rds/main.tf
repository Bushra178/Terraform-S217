# Create RDS db Instance
resource "aws_db_instance" "wordpress_db" {
  allocated_storage    = var.db_allocated_storage
  storage_type         = var.db_storage_type
  engine               = var.db_engine
  instance_class       = var.db_instance_class
  identifier           = var.db_identifier
  db_name              = var.db_name
  username             = var.db_user
  password             = var.db_password
  parameter_group_name = var.db_parameter_group_name
  publicly_accessible  = var.publicly_accessible
  vpc_security_group_ids = [var.rds_sg]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  multi_az               = var.multi_az
  skip_final_snapshot    = var.skip_final_snapshot
  final_snapshot_identifier = "${var.final_snapshot_identifier}-${local.timestamp}"
  //depends_on = [var.dependency]
  
   tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-db"
    }
  )
}

# Create Subnet group for database
resource "aws_db_subnet_group" "main" {
  name       = var.subnet_group_name
  subnet_ids = var.private_subnet_ids

   tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-db-subnet-group"
    }
  )
}


