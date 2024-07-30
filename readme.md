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
| Variável                        | Exemplo                           | Detalhes |
| :---                            | :---                              | :---     |
| DOMAIN_BASE                     | brunoferreira86dev.com            |
| MAGENTO_ADMIN_EMAIL             | brunoferreira86dev@gmail.com      |
| MAGENTO_ADMIN_FIRSTNAME         | Bruno                             |
| MAGENTO_ADMIN_LASTNAME          | Ferreira                          |
| MAGENTO_ADMIN_USER              | magentouser                       |
| RDS_1_DB_NAME                   | magentodb                         |
| RDS_1_DB_USERNAME               | magentoadmin                      |
| REGIAO                          | us-east-1                         |
| REMOTE_STATE_BUCKET             | myuser-remote-state-magento       |
| STATIC_FILES_BUCKET_NAME        | myuser-static-files-magento       | Pasta pub/media do magento será sincronizada nesse bucket.

### Github Secrets
| Variável                                | Exemplo                           | Detalhes |
| :---                                    | :---------------                  | :---     |
| AWS_DEV_CLI_ADMIN_KEY                   |                                   |
| AWS_DEV_CLI_ADMIN_SECRET                |                                   |
| AWS_DEV_CLI_ADMIN_SSH_PRIVATE_KEY       |                                   |
| MAGENTO_ADMIN_PASSWORD                  | your-password                     |
| MAGENTO_PRIVATE_KEY                     |                                   | Chave pública do Magento gerada em sua contada do Adobe 
| MAGENTO_PUBLIC_KEY                      |                                   | Chave privada do Magento gerada em sua contada do Adobe 
| RDS_1_DB_PASSWORD                       | your-password                     |
| REDIS_PASSWORD                          | your-password                     |
