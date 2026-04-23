variable "table_name" {
  description = "Nombre de la tabla de usuarios"
  type        = string
}

variable "tags" {
  description = "Tags comunes"
  type        = map(string)
  default     = {}
}
