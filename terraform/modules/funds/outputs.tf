output "table_arn" {
  description = "ARN de la tabla funds"
  value       = module.dynamodb.table_arn
}

output "table_name" {
  description = "Nombre de la tabla funds"
  value       = module.dynamodb.table_name
}

output "get_funds_name" {
  value = module.lambda.get_funds_name
}

output "get_fund_by_id_name" {
  value = module.lambda.get_fund_by_id_name
}