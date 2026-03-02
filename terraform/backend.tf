terraform {
  backend "s3" {
    bucket = "value"
    key = "java-login-App/terraform.tfstate"
    region = "us-east-1"

    
    dynamodb_table = "terraform-lock"
  }
}