#Create S3 bucket for storing state files
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "wordpress-state-bucket" 

  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-wordpress-state-bucket"
    }
  ) 
}

# Enable versioning for s3 bucket
resource "aws_s3_bucket_versioning" "state_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

#Create dynamo db for state locking
resource "aws_dynamodb_table" "state_lock_table" {
  name         = "wordpress-statelock-table"
  billing_mode = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.app_prefix}-wordpress-statelock-table"
    }
  ) 
}
