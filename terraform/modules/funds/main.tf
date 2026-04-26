# Orquestador: llama al submódulo DynamoDB
module "dynamodb" {
  source = "./dynamodb"

  env  = var.env
  tags = var.tags
}
