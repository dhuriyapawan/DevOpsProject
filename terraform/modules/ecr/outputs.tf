# outputs.tf
output "repository_name" {
  value = aws_ecr_repository.this.name
}


output "repository_urls" {
  description = "ECR repository URLs"

  value = {
    for repo_name, repo in aws_ecr_repository.this :
    repo_name => repo.repository_url
  }
}

output "repository_arns" {
  description = "ECR repository ARNs"

  value = {
    for repo_name, repo in aws_ecr_repository.this :
    repo_name => repo.arn
  }
}



output "registry_id" {
  value = aws_ecr_repository.this.registry_id
}