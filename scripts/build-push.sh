# build-push.sh
#!/bin/bash

set -e

AWS_REGION="ap-east-1"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

SERVICES=(
  "auth-service"
  "user-service"
  "order-service"
)

echo "======================================="
echo "Logging into Amazon ECR"
echo "======================================="

aws ecr get-login-password --region ${AWS_REGION} | docker login \
  --username AWS \
  --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

echo "======================================="
echo "Building and Pushing Images"
echo "======================================="

for SERVICE in "${SERVICES[@]}"
do
  IMAGE_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${SERVICE}:latest"

  echo "---------------------------------------"
  echo "Building ${SERVICE}"
  echo "---------------------------------------"

  docker build -t ${SERVICE}:latest ./services/${SERVICE}

  docker tag ${SERVICE}:latest ${IMAGE_URI}

  echo "---------------------------------------"
  echo "Pushing ${SERVICE}"
  echo "---------------------------------------"

  docker push ${IMAGE_URI}

done

echo "======================================="
echo "All Images Pushed Successfully"
echo "======================================="