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

variable "eks_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.30"
}

variable "instance_types" {
  description = "EKS worker node instance types"
  type        = list(string)

  default = ["t3.medium"]
}

variable "capacity_type" {
  description = "ON_DEMAND or SPOT"
  type        = string
  default     = "ON_DEMAND"
}

variable "desired_size" {
  description = "Desired node count"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum node count"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Minimum node count"
  type        = number
  default     = 1
}