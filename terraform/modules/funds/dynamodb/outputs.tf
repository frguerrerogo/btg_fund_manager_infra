output "table_arn" {
  description = "ARN de la tabla funds"
  value       = aws_dynamodb_table.funds.arn
}

output "table_name" {
  description = "Nombre de la tabla funds"
  value       = aws_dynamodb_table.funds.name
}

output "table_id" {
  description = "ID de la tabla funds"
  value       = aws_dynamodb_table.funds.id
}
