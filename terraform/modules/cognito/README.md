# README.md
# Cognito Module

Creates:

- Cognito User Pool
- Cognito App Client

## Usage

```hcl
module "cognito" {
  source = "../../modules/cognito"

  environment = var.environment
}