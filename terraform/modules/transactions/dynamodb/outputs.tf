output "table_arn" {
  description = "ARN de la tabla transactions"
  value       = aws_dynamodb_table.transactions.arn
}

output "table_name" {
  description = "Nombre de la tabla transactions"
  value       = aws_dynamodb_table.transactions.name
}

output "table_id" {
  description = "ID de la tabla transactions"
  value       = aws_dynamodb_table.transactions.id
}

output "gsi_name" {
  description = "Nombre del GSI (Global Secondary Index)"
  value       = "fund_id-created_at-index"
}
