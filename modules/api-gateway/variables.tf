variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "Lambda invoke ARN (used for integration)"
  type        = string
}

# ✅ This variable must exist for Lambda permission
variable "lambda_function_name" {
  description = "Lambda function name (used for permissions)"
  type        = string
}

variable "route_key" {
  description = "HTTP route (e.g. GET /hello)"
  type        = string
  default     = "GET /"
}

variable "stage_name" {
  description = "API Gateway stage name"
  type        = string
  default     = "$default"
}
