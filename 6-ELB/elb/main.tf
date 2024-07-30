data "terraform_remote_state" "remote-state-vpc" {
  backend = "s3"
  config = {
    region = var.regiao
    bucket = var.remote-state-bucket
    key    = "VPC Network/terraform.tfstate"
  }
}

data "terraform_remote_state" "remote-ami" {
  backend = "s3"
  config = {
    region = var.regiao
    bucket = var.remote-state-bucket
    # key    = "AMI Create/terraform.tfstate"
    key    = "AMI Update/terraform.tfstate"
  }
}

data "terraform_remote_state" "remote-ssl-certificate" {
  backend = "s3"
  config = {
    region = var.regiao
    bucket = var.remote-state-bucket
    key    = "ACM-SSL/terraform.tfstate"
  }
}

data "terraform_remote_state" "remote-state-s3-static-files" {
  backend = "s3"
  config = {
    region = var.regiao
    bucket = var.remote-state-bucket
    key    = "S3 Static Files/terraform.tfstate"
  }
}

data "terraform_remote_state" "remote-state-elasticcache" {
  backend = "s3"
  config = {
    region = var.regiao
    bucket = var.remote-state-bucket
    key    = "Elastic Cache/terraform.tfstate"
  }
}