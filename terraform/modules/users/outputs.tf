output "table_arn" {
  description = "ARN de la tabla users"
  value       = module.dynamodb.table_arn
}

output "table_name" {
  description = "Nombre de la tabla users"
  value       = module.dynamodb.table_name
}