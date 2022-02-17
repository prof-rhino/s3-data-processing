provider "aws" {
  version = "~> 2.0"
  region  = var.region
}
terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    region         = "eu-central-1"
    key            = "terraformstatefile"
    bucket         = "terraformstatebucket58366"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  hash_key       = "LockID"
  name           = "terraform-locks"
  billing_mode   = "PAY_PER_REQUEST"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }
}