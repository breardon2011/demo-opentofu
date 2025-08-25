resource "null_resource" "frontend" {
  # Frontend service resources
  
  provisioner "local-exec" {
    command = "echo 'Deploying frontend service'"
  }
}
