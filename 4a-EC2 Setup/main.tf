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

module "ec2-setup" {
  source                  = "./ec2-setup"
  regiao                  = var.regiao
  remote-state-bucket     = var.remote-state-bucket
  shortnameid             = data.terraform_remote_state.remote-state-information.outputs.shortnameid
  domain-base             = var.domain-base
  ec2-ssh-keypair-name    = var.ec2-ssh-keypair-name
  rds-1-db-name           = var.rds-1-db-name
  rds-1-db-username       = var.rds-1-db-username
  rds-1-db-password       = var.rds-1-db-password
  magento-public-key      = var.magento-public-key
  magento-private-key     = var.magento-private-key
  magento-admin-email     = var.magento-admin-email
  magento-admin-firstname = var.magento-admin-firstname
  magento-admin-lastname  = var.magento-admin-lastname
  magento-admin-user      = var.magento-admin-user
  magento-admin-password  = var.magento-admin-password
}