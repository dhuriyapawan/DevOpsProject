# README.md
# EKS Module

This Terraform module creates:

- Amazon EKS Cluster
- Managed Node Group
- IAM Roles
- Security Groups
- SSM-enabled worker nodes

## Features

- Private subnet deployment
- Managed node groups
- SSM access only (No SSH)
- ECR pull access
- Production-ready structure

## Usage

```hcl
module "eks" {
  source = "../../modules/eks"

  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  eks_version   = "1.30"
  instance_types = ["t3.medium"]

  desired_size = 2
  min_size     = 1
  max_size     = 3
}