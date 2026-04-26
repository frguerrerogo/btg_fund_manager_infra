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

module "users" {
  source = "./modules/users"

  env  = var.env
  tags = local.common_tags
}

module "funds" {
  source = "./modules/funds"

  env  = var.env
  tags = local.common_tags
}

module "transactions" {
  source = "./modules/transactions"

  env  = var.env
  tags = local.common_tags
}