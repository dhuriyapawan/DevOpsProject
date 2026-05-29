# variables.tf
variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "allowed_security_group_ids" {
  description = "Security groups allowed to access RDS"
  type        = list(string)
}

variable "db_name" {
  description = "Database name"
  type        = string
}
 
variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
 
variable "instance_class" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.medium"
}

variable "engine_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "16.3"
}

variable "allocated_storage" {
  description = "Initial storage"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum autoscaling storage"
  type        = number
  default     = 100
}

variable "multi_az" {
  description = "Enable Multi-AZ"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Backup retention days"
  type        = number
  default     = 7
}