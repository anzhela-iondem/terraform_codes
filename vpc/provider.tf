# Configure the AWS provider
provider "aws" {
    region = var.region  
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
        key = "terraform-vpc/terraform.tfstate"
        region = "eu-central-1"
    }
}