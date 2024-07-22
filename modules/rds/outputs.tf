output "db_endpoint" {
  value = aws_db_instance.rds_db_instance.endpoint
}

output "db_password" {
  value = aws_secretsmanager_secret_version.db_creds_version.secret_string
}

output "secret_policy_arn" {
  value = aws_secretsmanager_secret.db_creds_secret.arn
}

output "db_arn" {
  value = aws_db_instance.rds_db_instance.arn
}

output "rds_arn" {
  value = aws_db_instance.rds_db_instance.arn
}