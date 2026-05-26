# README.md
# ECR Module

This Terraform module creates:

- Amazon ECR Repository
- Lifecycle Policy
- Image Scanning
- Encryption
- Optional Cross-Account Access

---

## Features

- Immutable image tags
- Automatic image scanning
- Lifecycle cleanup policy
- AES256 encryption
- Production-ready setup

---

## Usage

```hcl
module "ecr_users_service" {
  source = "../../modules/ecr"

  environment     = var.environment
  repository_name = "users-service"
}
```

---

## Example Multiple Repositories

```hcl
module "ecr_auth_service" {
  source = "../../modules/ecr"

  environment     = var.environment
  repository_name = "auth-service"
}

module "ecr_payment_service" {
  source = "../../modules/ecr"

  environment     = var.environment
  repository_name = "payment-service"
}
```

---

## Docker Login

```bash id="wltp4l"
aws ecr get-login-password \
  --region ap-south-1 | docker login \
  --username AWS \
  --password-stdin <ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com
```

---

## Push Docker Image

```bash id="s9u53g"
docker build -t users-service .

docker tag users-service:latest \
<ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/prod-users-service:latest

docker push \
<ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/prod-users-service:latest
```