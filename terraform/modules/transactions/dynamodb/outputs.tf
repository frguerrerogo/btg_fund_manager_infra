output "table_arn" {
  description = "ARN de la tabla transactions"
  value       = aws_dynamodb_table.transactions.arn
}

output "table_name" {
  description = "Nombre de la tabla transactions"
  value       = aws_dynamodb_table.transactions.id
}

output "table_id" {
  description = "ID de la tabla transactions"
  value       = aws_dynamodb_table.transactions.id
}

