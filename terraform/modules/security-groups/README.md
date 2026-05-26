# README.md
# Security Groups Module

This module creates:

- EKS Cluster Security Group
- Worker Node Security Group

## Usage

```hcl
module "security_groups" {
  source = "../../modules/security-groups"

  environment   = var.environment
  vpc_id        = module.vpc.vpc_id
  allowed_cidrs = ["0.0.0.0/0"]
}