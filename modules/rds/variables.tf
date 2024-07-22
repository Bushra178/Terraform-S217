variable "private_subnet_ids" {
  description = "List of private subnet IDs where the RDS instance will be deployed"
  type        = list(string)
}

variable "rds_sg_id" {
  description = "Security group ID for the RDS instance"
  type        = string
}

variable "db_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated storage in gigabytes for the RDS instance"
  type        = number
}

variable "db_storage_type" {
  description = "Storage type for the RDS instance (e.g., gp2, io1)"
  type        = string
}

variable "db_engine" {
  description = "Database engine type (e.g., mysql, postgres)"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class (e.g., db.t2.micro, db.m5.large)"
  type        = string
}

variable "db_name" {
  description = "Name of the initial database to create"
  type        = string
}

variable "db_user_name" {
  description = "Username for the master database user"
  type        = string
}

variable "db_param_group" {
  description = "Parameter group name or ARN to associate with the RDS instance"
  type        = string
}

variable "db_skip_final_snapshot" {
  description = "Whether to skip the final snapshot when deleting the RDS instance (true/false)"
  type        = bool
}

variable "db_final_snapshot_identifier" {
  description = "Identifier for the final snapshot when deleting the RDS instance"
  type        = string
}

variable "db_subnet_name" {
  description = "Name of the subnet group where the RDS instance will be deployed"
  type        = string
}

variable "pwd_length" {
  description = "Length of the generated password"
  type        = number
}

variable "pwd_special" {
  description = "Whether to include special characters in the generated password (true/false)"
  type        = bool
}

variable "pwd_override_special" {
  description = "Specific set of special characters to include in the generated password (optional)"
  type        = string
}

variable "secret_name" {
  description = "Name of the secret in AWS Secrets Manager or other secret management service"
  type        = string
}

variable "app_prefix" {
  description = "Prefix to be used for naming resources related to the application"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}
