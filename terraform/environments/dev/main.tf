# main.tf
############################################
# VPC
############################################

module "vpc" {
  source = "../../modules/vpc"

  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

############################################
# IAM
############################################

module "iam" {
  source = "../../modules/iam"

  environment = var.environment
  github_repo = var.github_repo
}

############################################
# SECURITY GROUPS
############################################

module "security_groups" {
  source = "../../modules/security-groups"

  environment   = var.environment
  vpc_id        = module.vpc.vpc_id
  allowed_cidrs = var.allowed_cidrs
}

############################################
# ECR
############################################


module "ecr" {
  source = "../../modules/ecr"
  environment = var.environment

  repositories = [
    "${var.environment}-users-service",
    "${var.environment}-orders-service",
    "${var.environment}-payments-service"
  ]
}



############################################
# EKS
############################################

module "eks" {
  source = "../../modules/eks"

  environment = var.environment
  # Module expects vpc_id and private_subnet_ids
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}

############################################
# RDS
############################################

module "rds" {
  source = "../../modules/rds"

  environment = var.environment

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  vpc_id = module.vpc.vpc_id

  private_subnet_ids = module.vpc.private_subnet_ids

  allowed_security_group_ids = [
    module.security_groups.node_group_sg_id
  ]
}

############################################
# COGNITO
############################################

module "cognito" {
  source = "../../modules/cognito"

  environment = var.environment
}

############################################
# SECRETS MANAGER
############################################

module "secrets_manager" {
  source = "../../modules/secrets-manager"

  environment = var.environment

  db_username = var.db_username
  db_password = var.db_password
}