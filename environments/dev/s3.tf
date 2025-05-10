module "s3_bucket" {
  source            = "../../modules/s3"
  bucket_name       = "kb-dev-bucket-unique-12345"  # Ensure it's globally unique
  enable_versioning = true
  force_destroy     = true
}

