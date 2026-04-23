variable "environment" {
  description = "Environment name"
  type        = string
  default     = "local"
}

variable "users_table_name" {
  description = "Nombre de la tabla de usuarios"
  type        = string
  default     = "users"
}

variable "funds_table_name" {
  description = "Nombre de la tabla de fondos"
  type        = string
  default     = "funds"
}

variable "transactions_table_name" {
  description = "Nombre de la tabla de transacciones"
  type        = string
  default     = "transactions"
}