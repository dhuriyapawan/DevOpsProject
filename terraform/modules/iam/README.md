# README.md
# IAM Module

This module creates:

- EKS Cluster IAM Role
- EKS Node Group IAM Role
- SSM permissions for nodes
- GitHub Actions OIDC Role
- GitHub Actions IAM Policy

## Usage

```hcl
module "iam" {
  source = "../../modules/iam"

  environment = var.environment
  github_repo = "your-org/your-repo"
}
