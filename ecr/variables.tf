variable "ecr_repo_name" {
  default = "flask_app_relq"
}


data "terraform_remote_state" "terraform-vpc" {
  backend = "s3"
  config = {
    bucket = "devops-project-frankfurt"
    key    = "terraform-vpc/terraform.tfstate"
    region = "eu-central-1"
  }
}

# Define local variables to use the outputs from the remote state
locals {
  region              = data.terraform_remote_state.terraform-vpc.outputs.region
}