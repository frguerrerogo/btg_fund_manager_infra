# Orquestador: llama al submódulo DynamoDB
module "dynamodb" {
  source = "./dynamodb"

  table_name = var.table_name
  tags       = var.tags
}
