# README.md
# Secrets Manager Module

Stores:

- Database credentials

## Usage

```hcl
module "secrets_manager" {
  source = "../../modules/secrets-manager"

  environment = var.environment
  db_username = var.db_username
  db_password = var.db_password
}