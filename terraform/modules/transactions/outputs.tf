output "table_arn" {
  description = "ARN de la tabla transactions"
  value       = module.dynamodb.table_arn
}

output "table_name" {
  description = "Nombre de la tabla transactions"
  value       = module.dynamodb.table_name
}