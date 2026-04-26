output "users_table_name" {
  description = "Nombre de la tabla users"
  value       = module.users.table_name
}

output "users_table_arn" {
  description = "ARN de la tabla users"
  value       = module.users.table_arn
}

output "funds_table_name" {
  description = "Nombre de la tabla funds"
  value       = module.funds.table_name
}

output "funds_table_arn" {
  description = "ARN de la tabla funds"
  value       = module.funds.table_arn
}

output "transactions_table_name" {
  description = "Nombre de la tabla transactions"
  value       = module.transactions.table_name
}

output "transactions_table_arn" {
  description = "ARN de la tabla transactions"
  value       = module.transactions.table_arn
}