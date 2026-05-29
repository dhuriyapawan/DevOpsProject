# main.tf
resource "aws_ecr_repository" "this" { 
  for_each = toset(var.repositories) 
  name = each.key 
  image_tag_mutability = "MUTABLE" 
 image_scanning_configuration { 
  scan_on_push = true 
  } 
  tags = { 
    Environment = "dev" 
    } 
}

# ================================
# LIFECYCLE POLIC
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
resource "aws_ecr_repository" "repos" {
  for_each = toset([
    "auth-service",
    "user-service",
    "order-service"
  ])

  name = each.value

  image_scanning_configuration {
    scan_on_push = true
  }
}