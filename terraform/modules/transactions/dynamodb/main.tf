resource "aws_dynamodb_table" "transactions" {
  name             = var.table_name
  billing_mode     = "PAY_PER_REQUEST"
  hash_key         = "user_id"
  range_key        = "created_at"

  attribute {
    name = "user_id"
    type = "S"
  }

  attribute {
    name = "created_at"
    type = "S"
  }

  attribute {
    name = "fund_id"
    type = "S"
  }

  # Global Secondary Index: Buscar transacciones por fondo
  global_secondary_index {
    name            = "fund_id-created_at-index"
    hash_key        = "fund_id"
    range_key       = "created_at"
    projection_type = "ALL"
  }

  tags = merge(
    var.tags,
    {
      Name = "Transactions Table"
      Type = "Primary"
    }
  )
}
