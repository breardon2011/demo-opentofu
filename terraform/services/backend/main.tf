resource "null_resource" "backend" {
  # Backend service resources
  
  provisioner "local-exec" {
    command = "echo 'Deploying backend service'"
  }
}








