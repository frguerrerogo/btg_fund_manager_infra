variable "table_name" {
  description = "Nombre de la tabla DynamoDB"
  type        = string
  default     = "funds"
}

variable "tags" {
  description = "Tags comunes del proyecto"
  type        = map(string)
  default     = {
    Project     = "my-app"
    Environment = "dev"
  }
}
