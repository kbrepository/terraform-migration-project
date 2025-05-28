terraform {
  backend "s3" {
    bucket = "terraform-migration-project-kb"
    key    = "dev/vpc/terraform.tfstate"
    region = "us-east-1"
    # dynamodb_table = "terraform-lock-table-kb"
    use_lock_table = true
  } 
}