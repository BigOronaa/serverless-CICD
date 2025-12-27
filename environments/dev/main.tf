
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket  = "terraform-state-great-learning"
    key     = "serverless/dev/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.region
}

# -------------------------------
# DynamoDB
# -------------------------------
module "dynamodb" {
  source = "../../modules/dynamodb"

  table_name = "hello-world-${var.environment}"
  hash_key   = "id"
}

# -------------------------------
# IAM Role for Lambda
# -------------------------------
resource "aws_iam_role" "lambda_role" {
  name = "lambda-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# -------------------------------
# Lambda
# -------------------------------
module "lambda" {
  source = "../../modules/lambda"

  function_name = "hello-world-${var.environment}"
  runtime       = "python3.9"
  handler       = "lambda_function.handler"
  filename      = "${path.module}/lambda.zip"
  role_arn      = aws_iam_role.lambda_role.arn

  environment_variables = {
    TABLE_NAME = module.dynamodb.table_name
  }
}

# -------------------------------
# API Gateway
# -------------------------------
module "api_gateway" {
  source = "../../modules/api-gateway"

  api_name             = "hello-api-${var.environment}"
  lambda_invoke_arn    = module.lambda.invoke_arn
  lambda_function_name = module.lambda.lambda_function_name
  route_key            = "GET /hello"
}
