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
        key = "terraform-eks-module/terraform.tfstate"
        region = "eu-central-1"
    }
}


# # Retrieve the EKS authentication token using the AWS CLI
# data "aws_eks_cluster_auth" "eks_cluster" {
#   depends_on = [ module.eks ]
#   name = module.eks.cluster_name
# }

# provider "kubernetes" {
#     host                   = module.eks.cluster_endpoint
#     cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#     token                  = data.aws_eks_cluster_auth.eks_cluster.token
# }


