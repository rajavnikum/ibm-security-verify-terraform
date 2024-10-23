variable "client_id" {
  description = "IBM Security Verify API Client I"
}

variable "client_secret" {
  description = "IBM Security Verify API Client Secret"
}

variable "token_url" {
  description = "OAuth2 token endpoint"
  default     = "https://<your-region>/v1.0/endpoint/default/token"
}

variable "api_url" {
  description = "Base URL for IBM Security Verify API"
  default     = "https://<your-region>.verify.ibm.com/v2.0"
}
