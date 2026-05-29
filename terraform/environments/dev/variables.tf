# variables.tf
############################################
# GENERAL
############################################

variable "environment" {
  type = string
  default = "dev"
}

variable "aws_region" {
  type = string
}

############################################
# NETWORKING
############################################

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}


############################################
# GITHUB
############################################

variable "github_repo" {
  type = string
}

############################################
# DATABASE
############################################

variable "db_name" {
  type = string
}

variable "db_username" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}

# CIDR
variable "allowed_cidrs" {
  description = "CIDR blocks allowed to access infrastructure"
  type        = list(string)

  default = [
    "0.0.0.0/0"
  ]
}
