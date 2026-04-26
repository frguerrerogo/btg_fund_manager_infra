output "table_name" {
  description = "Nombre de la tabla creada"
  value       = aws_dynamodb_table.funds.name
}

output "table_arn" {
  description = "ARN de la tabla (útil para permisos IAM)"
  value       = aws_dynamodb_table.funds.arn
}
