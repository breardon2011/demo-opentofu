resource "null_resource" "test" {}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.99.0"  # Changed from 5.100.0 to a specific older version
    }
    random = {
      source = "hashicorp/random" 
      version = "3.6.0"  # Changed from 3.7.2 to a specific older version
    }
    null = {
      source = "hashicorp/null"
      version = "3.1.0"  # Changed from 3.2.4 to a specific older version
    }
  }
}







