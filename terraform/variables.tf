variable "env" {
  type        = string
  description = "Deployment environment"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.env)
    error_message = "env must be dev, staging, or prod."
  }
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags for all resources"
  default     = {}
}

variable "functions_path" {
  type        = string
  description = "Ruta absoluta a la carpeta serverless/functions del backend"
}

variable "dynamodb_endpoint" {
  type        = string
  description = "Endpoint de DynamoDB. Vacío en AWS, http://localhost:4566 en local"
  default     = ""
}