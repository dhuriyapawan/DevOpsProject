# main.tf
resource "aws_ecr_repository" "this" {
  name                 = "${var.environment}-${var.repository_name}"
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Environment = var.environment
    Name        = "${var.environment}-${var.repository_name}"
  }
}

# ================================
# LIFECYCLE POLICY
# ================================

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1

        description = "Keep last 10 images"

        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = var.keep_image_count
        }

        action = {
          type = "expire"
        }
      }
    ]
  })
}

# ================================
# OPTIONAL REPOSITORY POLICY
# ================================

resource "aws_ecr_repository_policy" "this" {
  count      = var.enable_cross_account_access ? 1 : 0
  repository = aws_ecr_repository.this.name

  policy = jsonencode({
    Version = "2008-10-17"

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