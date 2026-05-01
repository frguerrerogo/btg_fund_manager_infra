# Orquestador: llama al submódulo DynamoDB
module "dynamodb" {
  source = "./dynamodb"

  env  = var.env
  tags = var.tags
}

module "lambda" {
  source = "./lambda"

  env               = var.env
  tags              = var.tags
  table_name        = module.dynamodb.table_name
  functions_path    = var.functions_path
  lambda_role_arn   = var.lambda_role_arn
  dynamodb_endpoint = var.dynamodb_endpoint
}