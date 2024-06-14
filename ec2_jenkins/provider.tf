# Configure the AWS provider
provider "aws" {
    region = local.region  
}

terraform {
    required_version = ">= 1.5.2"

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 5.9.0"
        }
    }

    backend "s3" {
        bucket = "devops-project-frankfurt"
        key = "terraform-ec2-jenkins/terraform.tfstate"
        region = "eu-central-1"
    }
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
  project_vpc_id      = data.terraform_remote_state.terraform-vpc.outputs.vpc_id
  public_subnets1_id  = data.terraform_remote_state.terraform-vpc.outputs.public_subnet_1_id
  public_subnets2_id  = data.terraform_remote_state.terraform-vpc.outputs.public_subnet_2_id
  private_subnets1_id = data.terraform_remote_state.terraform-vpc.outputs.private_subnet_1_id
  private_subnets2_id = data.terraform_remote_state.terraform-vpc.outputs.private_subnet_2_id
  region              = data.terraform_remote_state.terraform-vpc.outputs.region
}