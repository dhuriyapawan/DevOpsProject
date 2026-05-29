
variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "repositories" {
  description = "List of ECR repositories"
  type        = list(string)
}

variable "enable_cross_account_access" {
  description = "Enable cross-account ECR access"
  type        = bool

  default = false
}

variable "cross_account_arns" {
  description = "Cross-account IAM ARNs"
  type        = list(string)

  default = []
}
