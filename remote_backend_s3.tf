terraform {
  backend "s3" {
    bucket = "devops-proj-remote-state-bucket-261"
    key    = "flask-terraform-devops-project/terraform.tfvars"
    region = "eu-central-1"
  }
}
