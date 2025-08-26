resource "null_resource" "test" {}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.70.0"  # Different from 5.100.0, 5.99.0, and 5.80.0
    }
    random = {
      source = "hashicorp/random" 
      version = "3.4.0"  # Different from 3.7.2, 3.6.0, and 3.5.0
    }
    null = {
      source = "hashicorp/null"
      version = "3.1.1"  # Different from 3.2.4, 3.1.0, and 3.0.0
    }
  }
}














