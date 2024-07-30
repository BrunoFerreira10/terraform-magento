terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
  backend "s3" {}
}

data "terraform_remote_state" "remote-state-information" {
  backend = "s3"
  config = {
    region = var.regiao
    bucket = var.remote-state-bucket
    key    = "Remote State/terraform.tfstate"
  }
}

provider "aws" {
  region = var.regiao

  default_tags {
    tags = {
      "owner"      = data.terraform_remote_state.remote-state-information.outputs.autor
      "project"    = data.terraform_remote_state.remote-state-information.outputs.projeto
      "customer"   = data.terraform_remote_state.remote-state-information.outputs.cliente
      "managed-by" = "terraform"
    }
  }
}

module "s3-static-files" {
  source                    = "./s3-static-files"
  regiao                    = var.regiao
  remote-state-bucket       = var.remote-state-bucket
  shortnameid               = data.terraform_remote_state.remote-state-information.outputs.shortnameid
  static-files-bucket-name  = var.static-files-bucket-name
}