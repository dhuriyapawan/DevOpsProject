# README.md
# RDS PostgreSQL Module

Terraform module to create a production-ready PostgreSQL RDS instance.

## Features

- PostgreSQL RDS
- Private subnet deployment
- Security Group
- CloudWatch logs
- Storage autoscaling
- Performance Insights
- Multi-AZ support
- Encrypted storage

---

## Usage

```hcl
module "rds" {
  source = "../../modules/rds"

  environment = var.environment

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  allowed_security_group_ids = [
    module.eks.node_security_group_id
  ]

  db_name     = "microservices"
  db_username = "postgres"
  db_password = var.db_password

  instance_class = "db.t3.medium"
}