terraform {
  backend "s3" {
    bucket         = "s3-terraform-state-jorge-quitian"
    key            = "simetric/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = "true"
  }
}