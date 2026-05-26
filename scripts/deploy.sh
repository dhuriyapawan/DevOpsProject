# deploy.sh
#!/bin/bash

set -e

ENVIRONMENT=${1:-prod}

echo "======================================="
echo "Deploying Infrastructure"
echo "Environment: ${ENVIRONMENT}"
echo "======================================="

cd terraform/environments/${ENVIRONMENT}

echo "Initializing Terraform..."
terraform init

echo "Validating Terraform..."
terraform validate

echo "Planning Terraform..."
terraform plan -out=tfplan

echo "Applying Terraform..."
terraform apply -auto-approve tfplan

echo "======================================="
echo "Updating kubeconfig"
echo "======================================="

CLUSTER_NAME=$(terraform output -raw eks_cluster_name)

aws eks update-kubeconfig \
  --region ap-south-1 \
  --name ${CLUSTER_NAME}

echo "======================================="
echo "Deploying Kubernetes Resources"
echo "======================================="

cd ../../../kubernetes

kubectl apply -f auth-service/
kubectl apply -f user-service/
kubectl apply -f order-service/

echo "======================================="
echo "Deploying ArgoCD"
echo "======================================="

kubectl apply -f argocd/install.yaml
kubectl apply -f argocd/projects.yaml
kubectl apply -f argocd/application.yaml

echo "======================================="
echo "Deployment Completed Successfully"
echo "======================================="