terraform {
  backend "s3" {
    bucket = "terraform-state-frontend"
    key    = "frontend/terraform.tfstate"
    region = "us-west-2"
  }
}
