# # main.tf

# ---

# # `modules/cognito/main.tf`

# ```hcl
resource "aws_cognito_user_pool" "this" {
  name = "${var.environment}-user-pool"

  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_uppercase = true
    require_numbers   = true
    require_symbols   = true
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_cognito_user_pool_client" "this" {
  name         = "${var.environment}-client"
  user_pool_id = aws_cognito_user_pool.this.id

  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]
}