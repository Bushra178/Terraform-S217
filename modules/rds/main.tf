#Create db instance
resource "aws_db_instance" "rds_db_instance" {
  identifier           = var.db_identifier
  allocated_storage    = var.db_allocated_storage
  storage_type         = var.db_storage_type
  engine               = var.db_engine
  instance_class       = var.db_instance_class
  db_name              = var.db_name
  username             = var.db_user_name
  password             = aws_secretsmanager_secret_version.db_creds_version.secret_string
  vpc_security_group_ids = [var.rds_sg_id]
  db_subnet_group_name = aws_db_subnet_group.main.name
  parameter_group_name = var.db_param_group
  skip_final_snapshot    = var.db_skip_final_snapshot
  final_snapshot_identifier = "${var.db_final_snapshot_identifier}-${local.timestamp}"
  multi_az = false
  
  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-db"
    }
  ) 
}

#Create subnet group for db
resource "aws_db_subnet_group" "main" {
  name       = var.db_subnet_name
  subnet_ids = var.private_subnet_ids
  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-subnet-group"
    }
  ) 
}

#AWS Secret Manager Password
resource "random_password" "rds_password" {
  length           = var.pwd_length
  special          = var.pwd_special
  override_special = var.pwd_override_special
}

# Create the Secret in AWS Secrets Manager
resource "aws_secretsmanager_secret" "db_creds_secret" {
  name = var.secret_name

 tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-db-secret"
    }
  ) 
}

resource "aws_secretsmanager_secret_version" "db_creds_version" {
  secret_id     = aws_secretsmanager_secret.db_creds_secret.id
  secret_string = random_password.rds_password.result
}
