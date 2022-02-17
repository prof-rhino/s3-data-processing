module "s3_data_reverser" {
  source              = "../../modules/s3_data_reverse"
  env                 = var.env
  lambda_archive_path = var.lambda_archive_path
  region              = var.region
}

