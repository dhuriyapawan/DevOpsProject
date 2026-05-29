
############################################
# ECR REPOSITORIES
############################################

resource "aws_ecr_repository" "this" {
  for_each = toset(var.repositories)

  name = "${var.environment}-${each.key}"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}


############################################
# LIFECYCLE POLICY
############################################

resource "aws_ecr_lifecycle_policy" "this" {
  for_each = aws_ecr_repository.this

  repository = each.value.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 10 images"

        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }

        action = {
          type = "expire"
        }
      }
    ]
  })
}

############################################
# OPTIONAL CROSS ACCOUNT POLICY
############################################

resource "aws_ecr_repository_policy" "cross_account" {
  for_each = var.enable_cross_account_access ? aws_ecr_repository.this : {}

  repository = each.value.name

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AllowCrossAccountPull"
        Effect = "Allow"

        Principal = {
          AWS = var.cross_account_arns
        }

        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
      }
    ]
  })
}
