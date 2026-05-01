variable "env" {
  type        = string
  description = "Deployment environment"
}

variable "tags" {
  type        = map(string)
  description = "Common tags for all resources"
}

variable "functions_path" {
  type        = string
  description = "Ruta a la carpeta funds/ del backend"
}

variable "lambda_role_arn" {
  type        = string
  description = "ARN del IAM role para las Lambdas"
}

variable "dynamodb_endpoint" {
  type    = string
  default = ""
}