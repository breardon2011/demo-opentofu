resource "null_resource" "test29" {}


terraform { 
  cloud { 
    
    organization = "briancorporation123" 

    workspaces { 
      name = "brispace" 
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












