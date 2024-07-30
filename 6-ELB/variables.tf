variable "regiao" {
  type        = string
  description = "Região onde a infraestrutura será criada."
}

variable "remote-state-bucket" {
  type        = string
  description = "Bucket name onde está o remote state"
}

variable "domain-base" {
  type        = string
  description = "Domínio base da aplicação"
}

variable "ec2-ssh-keypair-name" {
  type = string
}