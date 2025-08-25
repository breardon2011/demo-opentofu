resource "null_resource" "infrastructure" {
  # Core infrastructure resources
  
  provisioner "local-exec" {
    command = templatefile("${path.module}/files/template.tfpl", {
      region       = var.region
      environment  = var.environment
      project_name = var.project_name
    })
  }
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "demo-project"
}
