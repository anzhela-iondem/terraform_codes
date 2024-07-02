variable "region" {
    default = "eu-central-1"  # Frankfurt
}

variable "image_ami" {
    default = "ami-0fd3d9a52f5e08c9c" # Jenkins
}

variable "key_name" {
    default = "test_relq" # SSH key name
}
