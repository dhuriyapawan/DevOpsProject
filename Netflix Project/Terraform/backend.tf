terraform {
  required_version = ">= 1.5.7, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.14.1"
    }
  }

  cloud {
    organization = "<YOUR_TFC_ORG>"        # replace with your Terraform Cloud organization
    workspaces {
      name = "<YOUR_TFC_WORKSPACE>"        # or use prefix = "..." if you use multiple workspaces
    }
  }
}

provider "aws" {
  region = var.aws_region
}
