resource "aws_dynamodb_table" "funds" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "fund_id"

  attribute {
    name = "fund_id"
    type = "S"
  }

  tags = merge(
    var.tags,
    {
      Name = "Funds Table"
      Type = "Primary"
    }
  )
}
