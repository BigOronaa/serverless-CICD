variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "Lambda invoke ARN"
  type        = string
}

variable "route_key" {
  description = "HTTP method and route (e.g., GET /hello)"
  type        = string
  default     = "GET /"
}

variable "stage_name" {
  description = "API Gateway stage name"
  type        = string
  default     = "$default"
}
