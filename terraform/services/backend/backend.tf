terraform {
  backend "s3" {
    bucket = "terraform-state-backend"
    key    = "backend/terraform.tfstate"
    region = "us-west-2"
  }
}
