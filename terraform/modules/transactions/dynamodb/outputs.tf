output "table_arn" {
  description = "ARN de la tabla transactions"
  value       = aws_dynamodb_table.transactions.arn
}

output "table_name" {
  description = "Nombre de la tabla transactions"
  value       = aws_dynamodb_table.transactions.name
}

output "gsi_name" {
  description = "Nombre del GSI para buscar por user_id"
  value       = "user_id-index"
}