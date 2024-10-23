terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "~> 2.0"
    }
  }
}

provider "http" {}

# Data block to get the OAuth2 token
data "http" "auth" {
  url = var.token_url

  request_headers = {
    Content-Type = "application/x-www-form-urlencoded"
  }

  request_body = "grant_type=client_credentials&client_id=${var.client_id}&client_secret=${var.client_secret}&scope=openid"
}

# iResource to create the user
resource "http_request" "create_user" {
  url    = "${var.api_url}/Users"
  method = "POST"

  request_headers = {
    Authorization = "Bearer ${jsondecode(data.http.auth.body).access_token}"
    Content-Type  = "application/json"
  }

  request_body = jsonencode({
    userName = "john.doe"
    name = {
      givenName  = "John"
      familyName = "Doe"
    }
    emails = [{
      value   = "john.doe@example.com"
      primary = true
    }]
    password = "Password123!"
    active   = true
  })

  response_body = "string"
}

output "create_user_response" {
  value = http_request.create_user.response_body
}
