# outputs.tf
############################################
# VPC
############################################

output "vpc_id" {
  value = module.vpc.vpc_id
}

############################################
# EKS
############################################

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

############################################
# RDS
############################################

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

############################################
# COGNITO
############################################

output "cognito_user_pool_id" {
  value = module.cognito.user_pool_id
}

############################################
# SECRETS MANAGER
############################################

output "secret_arn" {
  value = module.secrets_manager.secret_arn
}
