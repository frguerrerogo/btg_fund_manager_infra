output "get_funds_arn" {
  value = aws_lambda_function.get_funds.arn
}

output "get_funds_name" {
  value = aws_lambda_function.get_funds.function_name
}

output "get_fund_by_id_arn" {
  value = aws_lambda_function.get_fund_by_id.arn
}

output "get_fund_by_id_name" {
  value = aws_lambda_function.get_fund_by_id.function_name
}