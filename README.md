# Terraform Codes for Cloud Infrastructure

This repository contains Terraform configurations to create and manage cloud infrastructure. The modules and scripts included here are designed to simplify the process of setting up various components such as VPCs, EC2 instances, and EKS clusters.

## Contents

- `ec2_jenkins/`: Terraform code to set up an EC2 instance with Jenkins.
- `modul_eks/`: Terraform module for creating and managing an EKS cluster.
- `vpc/`: Terraform scripts to create a Virtual Private Cloud (VPC).

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) 0.12+ installed.
- AWS CLI configured with appropriate permissions.
- A basic understanding of Terraform and AWS services.

## Getting Started

1. **Clone the repository:**
    ```sh
    git clone https://github.com/anzhela-iondem/terraform_codes.git
    cd terraform_codes
    ```

2. **Create the VPC (network infrastructure) first:**
    ```sh
    cd vpc
    terraform init
    terraform apply
    ```

3. **Navigate to the desired resource directory and apply the configuration, e.g., for EKS:**
    ```sh
    cd ../modul_eks
    terraform init
    terraform apply
    ```

## Configuration

Each module may have specific variables that need to be configured. Refer to the `variables.tf` file in the respective module directory for required and optional parameters.
