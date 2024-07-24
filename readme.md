# Sobre o projeto
## Descrição
Implementação de sitema Magento na AWS com IaC Terraform com repositório no 
Github. Execução dos scripts Terraform através do Github Actions.

## Estrutura
O projeto conta com vários **'sub-projetos'** Terraform, os quais se comunicam 
usando um **'remote state'** alocado em um S3.
Com isso é possível criar e destruir os recursos de forma individual.

# Requisitos

## Requisitos da AWS
  - Usuário com acesso CLI e politicas de admintração do ambiente. 
  - Chave ssh criada para acesso via ssh.
  - Dominio e HostedZone (Router 53) previamente criados.

## Variavéis e Secrets configuradas no Github Actions
### Github Vars
| Variável              | Exemplo                       |
| :---                  |               ---:            |
| DOMAIN_BASE           | brunoferreira86dev.com        |


