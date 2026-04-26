resource "aws_dynamodb_table" "funds" {
  name         = "${var.env}-funds"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
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
