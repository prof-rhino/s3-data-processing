resource "aws_s3_bucket" "dataBucket" {
  bucket = "databucket58366"
  acl    = "private"
  lifecycle {
    prevent_destroy = true
  }
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }


}

resource "aws_s3_bucket" "reverseDataBucket" {
  bucket = "reversebucket58366"
  acl    = "private"
  lifecycle {
    prevent_destroy = true
  }
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

}


resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraformstatebucket58366"
  acl    = "private"
  lifecycle {
    prevent_destroy = true
  }
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_notification" "bucket_terraform_notification" {
  bucket = aws_s3_bucket.dataBucket.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_copy_reversed_data_function.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_terraform_bucket]
}
