# Sobre o projeto
## Descrição
Implementação de sistema Magento na AWS usando IaC Terraform e repositório no 
Github.<br>
Execução dos scripts Terraform através do Github Actions.

## Estrutura
O projeto conta com vários **'sub-projetos'** Terraform, os quais se comunicam 
usando um **'remote state'** alocado em um S3.<br>
Com isso é possível criar e destruir os recursos de forma individual.

# Requisitos

## Requisitos da AWS
  - Usuário com acesso CLI e politicas de admintração do ambiente. 
  - Chave ssh criada para acesso via ssh.
  - Dominio e HostedZone (Router 53) previamente criados.

## Variavéis e Secrets configuradas no Github Actions
### Github Vars
| Variável                        | Exemplo                           |
| :---                            |                              ---: |
| DOMAIN_BASE                     | brunoferreira86dev.com            |
| MAGENTO_ADMIN_EMAIL             | brunoferreira86dev@gmail.com      |
| MAGENTO_ADMIN_FIRSTNAME         | Bruno                             |
| MAGENTO_ADMIN_LASTNAME          | Ferreira                          |
| MAGENTO_ADMIN_USER              | magentouser                       |
| RDS_1_DB_NAME                   | magentodb                         |
| RDS_1_DB_USERNAME               | magentoadmin                      |
| REGIAO                          | us-east-1                         |
| REMOTE_STATE_BUCKET             | myuser-remote-state-magento       |

### Github Secrets
| Variável                                | Exemplo                           |
| :---                                    |                              ---: |
| AWS_DEV_CLI_ADMIN_KEY                   |                                   |
| AWS_DEV_CLI_ADMIN_SECRET                |                                   |
| AWS_DEV_CLI_ADMIN_SSH_PRIVATE_KEY       |                                   |
| AWS_DEV_CLI_ADMIN_SSH_PUBLIC_KEY        |                                   |
| AWS_DEV_CLI_ADMIN_SSH_PUBLIC_KEY        |                                   |
| MAGENTO_PRIVATE_KEY                     |                                   |
| MAGENTO_PUBLIC_KEY                      |                                   |
| RDS_1_DB_PASSWORD                       |                                   |
| REDIS_PASSWORD                          |                                   |
