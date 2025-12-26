output "api_endpoint" {
  description = "Invoke URL of the API Gateway"
  value       = aws_apigatewayv2_api.this.api_endpoint
}


output "api_id" {
  description = "API Gateway ID"
  value       = aws_apigatewayv2_api.this.id
}
