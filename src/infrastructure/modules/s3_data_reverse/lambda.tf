resource "aws_lambda_function" "s3_copy_reversed_data_function" {
  filename         = data.archive_file.my_lambda_function.output_path
  source_code_hash = data.archive_file.my_lambda_function.output_base64sha256
  function_name    = "s3_copy_reversed_data_lambda"
  role             = aws_iam_role.s3_copy_function.arn
  handler          = "s3_copy_reversed_data_lambda.handler"
  runtime          = "python3.7"

  environment {
    variables = {
      DST_BUCKET = aws_s3_bucket.reverseDataBucket.id,
      REGION     = var.region
    }
  }
  tags = {
    Name = "s3_copy_reversed_data_lambda"
  }
}

data "archive_file" "my_lambda_function" {
  source_dir  = var.lambda_archive_path
  output_path = "${var.lambda_archive_path}/s3_copy_reversed_data_function.zip"
  type        = "zip"
}


