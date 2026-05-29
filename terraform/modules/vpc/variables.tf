# variables.tf
variable "environment" {
  type = string
}

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

variable "allowed_cidrs" {
  description = "CIDR blocks allowed to access infrastructure"
  type        = list(string)

  default = [
    "0.0.0.0/0"
  ]
}
