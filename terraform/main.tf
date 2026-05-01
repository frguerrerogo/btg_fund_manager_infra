locals {
  common_tags = merge(
    var.common_tags,
    {
      Environment = var.env
      ManagedBy   = "Terraform"
      Project     = "BTG Fund Manager"
    }
  )
}



module "funds" {
  source = "./modules/funds"

  env               = var.env
  tags              = local.common_tags
  functions_path    = var.functions_path
  lambda_role_arn   = aws_iam_role.lambda_role.arn
  dynamodb_endpoint = var.dynamodb_endpoint
}

module "transactions" {
  source = "./modules/transactions"

  env  = var.env
  tags = local.common_tags
}
module "users" {
  source = "./modules/users"

  env  = var.env
  tags = local.common_tags

}