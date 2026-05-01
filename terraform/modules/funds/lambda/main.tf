data "archive_file" "get_funds" {
  type        = "zip"
  source_dir  = "${var.functions_path}/funds"
  output_path = "${path.module}/zips/funds.zip"
}

resource "aws_lambda_function" "get_funds" {
  function_name    = "${var.env}-get-funds"
  filename         = data.archive_file.get_funds.output_path
  source_code_hash = data.archive_file.get_funds.output_base64sha256
  handler          = "get_funds/index.handler"
  runtime          = "nodejs22.x"
  role             = var.lambda_role_arn

  environment {
    variables = {
      TABLE_NAME        = var.table_name
      AWS_REGION        = var.region
      DYNAMODB_ENDPOINT = var.dynamodb_endpoint
    }
  }

  tags = var.tags
}

resource "aws_lambda_function" "get_fund_by_id" {
  function_name    = "${var.env}-get-fund-by-id"
  filename         = data.archive_file.get_funds.output_path
  source_code_hash = data.archive_file.get_funds.output_base64sha256
  handler          = "get_fund_by_id/index.handler"
  runtime          = "nodejs22.x"
  role             = var.lambda_role_arn

  environment {
    variables = {
      TABLE_NAME        = var.table_name
      AWS_REGION        = var.region
      DYNAMODB_ENDPOINT = var.dynamodb_endpoint
    }
  }

  tags = var.tags
}