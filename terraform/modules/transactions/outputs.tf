output "table_name" {
  description = "Nombre de la tabla transactions"
  value       = module.dynamodb.table_name
}

output "table_arn" {
  description = "ARN de la tabla transactions"
  value       = module.dynamodb.table_arn
}

output "table_id" {
  description = "ID de la tabla transactions"
  value       = module.dynamodb.table_id
}

output "gsi_name" {
  description = "Nombre del GSI (Global Secondary Index)"
  value       = "fund_id-created_at-index"
}
