output "table_arn" {
  description = "ARN de la tabla users"
  value       = aws_dynamodb_table.users.arn
}

output "table_name" {
  description = "Nombre de la tabla users"
  value       = aws_dynamodb_table.users.name
}