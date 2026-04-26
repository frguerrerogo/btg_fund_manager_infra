resource "aws_dynamodb_table" "transactions" {
  name         = "${var.env}-transactions"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "user_id"

  attribute {
    name = "user_id"
    type = "S"
  }

  tags = merge(
    var.tags,
    {
      Name = "Transactions Table"
      Type = "Primary"
    }
  )
}
