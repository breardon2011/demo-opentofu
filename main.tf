resource "null_resource" "test29" {}









terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.100.0"
    }
    random = {
      source = "hashicorp/random" 
      version = "3.7.2"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.4"
    }
  }
}



#variable "TEST" {
#  default = "hello"
#}

#variable "SECRET" {
#  default = "shhh"
#}

#output "test" {
#  value = var.TEST
#}

#output "secret" {
#  value = var.SECRET
#}

#output "secret2" {
#  value = var.SECRET
#}












