# destroy.sh
#!/bin/bash

set -e

ENVIRONMENT=${1:-prod}

echo "======================================="
echo "Destroying Infrastructure"
echo "Environment: ${ENVIRONMENT}"
echo "======================================="

cd terraform/environments/${ENVIRONMENT}

echo "Terraform Init..."
terraform init

echo "Terraform Destroy..."
terraform destroy -auto-approve

echo "======================================="
echo "Infrastructure Destroyed"
echo "======================================="