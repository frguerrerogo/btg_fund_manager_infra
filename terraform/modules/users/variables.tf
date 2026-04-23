variable "table_name" {
  description = "Nombre de la tabla de usuarios"
  type        = string
}

variable "tags" {
  description = "Tags comunes para todos los recursos"
  type        = map(string)
  default     = {}
}
