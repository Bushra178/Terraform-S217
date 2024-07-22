variable "secret_policy_arn" {
  description = "ARN of the secret for db password"
  type = string
}

variable "db_arn" {
  description = "db arn"
  type = string
}

variable "asg_arn" {
  description = "asg arn"
  type = string
}

variable "s3_bucket_arn" {
  description = "s3 bucket ARN"
  type = string
}

variable "dynamodb_arn" {
  description = "ARN of the dynamodb"
  type = string
}
