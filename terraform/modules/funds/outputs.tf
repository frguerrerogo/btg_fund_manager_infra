output "table_name" {
  description = "Nombre de la tabla funds"
  value       = module.dynamodb.table_name
}

output "table_arn" {
  description = "ARN de la tabla funds"
  value       = module.dynamodb.table_arn
}

output "table_id" {
  description = "ID de la tabla funds"
  value       = module.dynamodb.table_id
}
