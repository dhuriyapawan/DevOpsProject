# variables.tf
variable "environment" {
  description = "Environment name"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository in org/repo format"
  type        = string
}