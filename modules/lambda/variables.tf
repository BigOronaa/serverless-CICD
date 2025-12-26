variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "runtime" {
  description = "Lambda runtime"
  type        = string
}

variable "handler" {
  description = "Lambda handler"
  type        = string
}

variable "filename" {
  description = "Path to the Lambda zip file"
  type        = string
}

variable "role_arn" {
  description = "IAM role ARN for Lambda execution"
  type        = string
}

variable "environment_variables" {
  description = "Environment variables for Lambda"
  type        = map(string)
  default     = {}
}
