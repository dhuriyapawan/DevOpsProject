# # main.tf

# ---

# # `modules/secrets-manager/main.tf`

# ```hcl
resource "aws_secretsmanager_secret" "db_credentials" {
  name = "${var.environment}/database/credentials"

  recovery_window_in_days = 7

  tags = {
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "db_credentials_value" {
  secret_id = aws_secretsmanager_secret.db_credentials.id

  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
  })
} 