variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "hash_key" {
  description = "Partition key for the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "Billing mode for the DynamoDB table"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "attributes" {
  description = "List of attribute definitions"
  type = list(object({
    name = string
    type = string
  }))
}
