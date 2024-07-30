data "terraform_remote_state" "remote-state-vpc" {
  backend = "s3"
  config = {
    region = var.regiao
    bucket = var.remote-state-bucket
    key    = "VPC Network/terraform.tfstate"
  }
}

data "terraform_remote_state" "remote-state-rds" {
  backend = "s3"
  config = {
    region = var.regiao
    bucket = var.remote-state-bucket
    key    = "RDS Database/terraform.tfstate"
  }
}

data "terraform_remote_state" "remote-state-opensearch" {
  backend = "s3"
  config = {
    region = var.regiao
    bucket = var.remote-state-bucket
    key    = "Open Search/terraform.tfstate"
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

data "terraform_remote_state" "remote-state-s3-static-files" {
  backend = "s3"
  config = {
    region = var.regiao
    bucket = var.remote-state-bucket
    key    = "S3 Static Files/terraform.tfstate"
  }
}

data "terraform_remote_state" "remote-state-efs" {
  backend = "s3"
  config = {
    region = var.regiao
    bucket = var.remote-state-bucket
    key    = "EFS/terraform.tfstate"
  }
}

data "terraform_remote_state" "remote-ami" {
  backend = "s3"
  config = {
    region = var.regiao
    bucket = var.remote-state-bucket
    key    = "AMI Create/terraform.tfstate"
  }
}