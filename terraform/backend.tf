terraform {
  backend "s3" {
    bucket = "cloud-bucket-1770975946"
    key = "java-login-App/terraform.tfstate"
    region = "us-east-1"


    dynamodb_table = "terraform-lock"
  }
}