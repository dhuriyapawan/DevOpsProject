
output "repository_names" {
  value = {
    for repo_name, repo in aws_ecr_repository.this :
    repo_name => repo.name
  }
}

output "repository_urls" {
  value = {
    for repo_name, repo in aws_ecr_repository.this :
    repo_name => repo.repository_url
  }
}

output "repository_arns" {
  value = {
    for repo_name, repo in aws_ecr_repository.this :
    repo_name => repo.arn
  }
}

output "registry_ids" {
  value = {
    for repo_name, repo in aws_ecr_repository.this :
    repo_name => repo.registry_id
  }
}

