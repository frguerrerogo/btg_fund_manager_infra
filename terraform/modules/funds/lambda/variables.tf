variable "env" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "functions_path" {
  type        = string
  description = "Ruta absoluta a la carpeta funds/ del backend"
}

variable "table_name" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "dynamodb_endpoint" {
  type        = string
  description = "Endpoint de DynamoDB. En local apunta a LocalStack"
  default     = ""
}

variable "lambda_role_arn" {
  type        = string
  description = "ARN del IAM role que usan las Lambdas"
}