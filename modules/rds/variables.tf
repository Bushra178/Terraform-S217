variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_user" {
  description = "The username for the database"
  type        = string
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "app_prefix" {
  description = "Prefix to use for environment resources"
  type        = string
}

variable "rds_sg" {
  description = "Security group ID for the RDS instance"
  type        = string
}

variable "db_allocated_storage" {
  description = "The allocated storage size for the RDS instance"
  type        = number
}

variable "db_storage_type" {
  description = "The storage type for the RDS instance"
  type        = string
}

variable "db_engine" {
  description = "The database engine for the RDS instance"
  type        = string
}

variable "db_instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}

variable "db_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
}

variable "db_parameter_group_name" {
  description = "The name of the parameter group for the RDS instance"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}

variable publicly_accessible {}
variable multi_az {}
variable skip_final_snapshot {}
variable final_snapshot_identifier {}
variable subnet_group_name {}

# variable "dependency" {
#   description = "The reource which should be created first"
#   type        = string
# }


