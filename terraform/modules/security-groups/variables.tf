# variables.tf
variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "allowed_cidrs" {
  type = list(string)

  default = [
    "0.0.0.0/0"
  ]
}