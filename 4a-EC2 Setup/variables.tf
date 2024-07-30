variable "regiao" {
  type        = string
  description = "Região onde a infraestrutura será criada."
}

variable "remote-state-bucket" {
  type        = string
  description = "Bucket name onde está o remote state"
}

variable "ec2-ssh-keypair-name" {
  type = string
}

variable "domain-base" {
  type = string
}

variable "rds-1-db-name" {
  type = string
}

variable "rds-1-db-username" {
  type = string
}

variable "rds-1-db-password" {
  type      = string
  sensitive = true
}

variable "magento-public-key" {
  type      = string
  sensitive = true
}

variable "magento-private-key" {
  type      = string
  sensitive = true
}

variable "magento-admin-email" {
  type = string
}

variable "magento-admin-firstname" {
  type = string
}

variable "magento-admin-lastname" {
  type = string
}

variable "magento-admin-user" {
  type = string
}

variable "magento-admin-password" {
  type      = string
  sensitive = true
}