# variables.tf
variable "environment" {
  description = "Environment name"
  type        = string
}


variable "repositories" {
  description = "List of ECR repositories"
  type        = list(string)
}



variable "image_tag_mutability" {
  description = "IMMUTABLE or MUTABLE"
  type        = string
  default     = "IMMUTABLE"
}

variable "keep_image_count" {
  description = "Number of images to retain"
  type        = number
  default     = 10
}

variable "enable_cross_account_access" {
  description = "Enable cross-account access"
  type        = bool
  default     = false
}

variable "cross_account_arns" {
  description = "List of AWS account ARNs allowed to pull images"
  type        = list(string)
  default     = []
}


variable "repositories" {
  type = list(string)
}