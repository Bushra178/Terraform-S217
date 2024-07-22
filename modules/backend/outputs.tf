output "s3_bucket_name" {
  description = "name of the s3 bucket"
  value = aws_s3_bucket.terraform_state_bucket.bucket
}

output "dynamo_db_name" {
  description = "name of the dynamodb"
  value = aws_dynamodb_table.state_lock_table.name
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value = aws_s3_bucket.terraform_state_bucket.arn
}

output "dynamodb_arn" {
  description = "ARN of the dynamodb"
  value = aws_dynamodb_table.state_lock_table.arn
}
