locals {
  common_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "BTG Fund Manager"
  }
}

module "users" {
  source = "./modules/users"

  table_name = var.users_table_name
  tags       = local.common_tags
}

module "funds" {
  source     = "./modules/funds"
  table_name = var.funds_table_name
  tags       = local.common_tags
}

module "transactions" {
  source = "./modules/transactions"

  table_name = var.transactions_table_name
  tags       = local.common_tags
}