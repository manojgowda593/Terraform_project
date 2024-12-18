terraform {
  backend "s3" {
    bucket = "statefile-of-terraform"
    key = "Terraform/statefile.tf"
    region = "ap-south-1"
  }
}