resource "aws_dynamodb_table" "users" {
  name         = "${var.env}-users"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = merge(
    var.tags,
    {
      Name = "Users Table"
      Type = "Primary"
    }
  )
}
