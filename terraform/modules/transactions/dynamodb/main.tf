resource "aws_dynamodb_table" "transactions" {
  name         = "${var.env}-transactions"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "user_id"
    type = "S"
  }

  global_secondary_index {
    name            = "user_id-index"
    hash_key        = "user_id"
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
