variable "db_engine" {
  default = "mysql"
}
variable engine_version {
  default = "8.0.32"
}
variable "instance_class" {
  default = "db.t3.micro"
}
variable "allocated_storage" {
  default = 5
}
variable "storage_type" {
  default = "gp2"
}
variable "db_name" {
  default = "flaskapp"
}
variable "db_username" {
  default = "admin_relq"

}
variable "db_password" {
  default = "relqpass"
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
  project_vpc_id      = data.terraform_remote_state.terraform-vpc.outputs.vpc_id
  database_subnets1_id = data.terraform_remote_state.terraform-vpc.outputs.database_subnet_1_id
  database_subnets2_id = data.terraform_remote_state.terraform-vpc.outputs.database_subnet_2_id
}