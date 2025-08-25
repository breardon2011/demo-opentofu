terraform {
  backend "s3" {
    bucket = "terraform-state-infra"
    key    = "infra/terraform.tfstate"
    region = "us-west-2"
  }
}
