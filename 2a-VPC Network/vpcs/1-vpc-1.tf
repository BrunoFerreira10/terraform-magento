# VPC
resource "aws_vpc" "vpc-1" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-${var.shortnameid}-1"
  }
}

# Network ACL
resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.vpc-1.default_network_acl_id

  tags = {
    Name = "nacl-vpc-${var.shortnameid}-1-default"
  }
}

resource "aws_network_acl" "nacl-vpc-1-private-subnets" {
  vpc_id = aws_vpc.vpc-1.id

  ingress {
    rule_no    = 100
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no    = 200
    protocol   = "tcp"
    from_port  = 3306
    to_port    = 3306
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  # ingress {    
  #   rule_no    = 300
  #   protocol   = "tcp"
  #   from_port  = 2049
  #   to_port    = 2049
  #   action     = "allow"
  #   cidr_block = "0.0.0.0/0"    
  # }

  ingress {
    rule_no    = 10000
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  # ByPass
  ingress {
    rule_no    = 11111
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  egress {
    rule_no    = 10000
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  # ByPass
  egress {
    rule_no    = 11111
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "nacl-vpc-${var.shortnameid}-1-private-subnets"
  }
}

resource "aws_network_acl" "nacl-vpc-1-public-subnets" {
  vpc_id = aws_vpc.vpc-1.id

  ingress {
    rule_no    = 100
    protocol   = "tcp"
    from_port  = 22
    to_port    = 22
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no    = 200
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no    = 300
    protocol   = "tcp"
    from_port  = 443
    to_port    = 443
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no    = 10000
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  # ByPass
  ingress {
    rule_no    = 11111
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  # egress {
  #   rule_no    = 100
  #   protocol   = "tcp"
  #   from_port  = 80
  #   to_port    = 80
  #   action     = "allow"
  #   cidr_block = "0.0.0.0/0"    
  # }

  egress {
    rule_no    = 200
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  egress {
    rule_no    = 300
    protocol   = "tcp"
    from_port  = 443
    to_port    = 443
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  egress {
    rule_no    = 10000
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  # ByPass
  egress {
    rule_no    = 11111
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "nacl-vpc-${var.shortnameid}-1-public-subnets"
  }
}

# Network ACL associations
resource "aws_network_acl_association" "nacl-association-vpc-1-subnet-private-1a" {
  network_acl_id = aws_network_acl.nacl-vpc-1-private-subnets.id
  subnet_id      = aws_subnet.subnet-vpc-1-private-1a.id
}
resource "aws_network_acl_association" "nacl-association-vpc-1-subnet-private-1b" {
  network_acl_id = aws_network_acl.nacl-vpc-1-private-subnets.id
  subnet_id      = aws_subnet.subnet-vpc-1-private-1b.id
}
resource "aws_network_acl_association" "nacl-association-vpc-1-subnet-private-1c" {
  network_acl_id = aws_network_acl.nacl-vpc-1-private-subnets.id
  subnet_id      = aws_subnet.subnet-vpc-1-private-1c.id
}

resource "aws_network_acl_association" "nacl-association-vpc-1-subnet-public-1a" {
  network_acl_id = aws_network_acl.nacl-vpc-1-public-subnets.id
  subnet_id      = aws_subnet.subnet-vpc-1-public-1a.id
}
resource "aws_network_acl_association" "nacl-association-vpc-1-subnet-public-1b" {
  network_acl_id = aws_network_acl.nacl-vpc-1-public-subnets.id
  subnet_id      = aws_subnet.subnet-vpc-1-public-1b.id
}
resource "aws_network_acl_association" "nacl-association-vpc-1-subnet-public-1c" {
  network_acl_id = aws_network_acl.nacl-vpc-1-public-subnets.id
  subnet_id      = aws_subnet.subnet-vpc-1-public-1c.id
}


# Public Subnet 1a
resource "aws_subnet" "subnet-vpc-1-public-1a" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet-vpc-${var.shortnameid}-1-public-1a"
  }
}

# Public Subnet 1b
resource "aws_subnet" "subnet-vpc-1-public-1b" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "subnet-vpc-${var.shortnameid}-1-public-1b"
  }
}

# Public Subnet 1c
resource "aws_subnet" "subnet-vpc-1-public-1c" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.1.5.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "subnet-vpc-${var.shortnameid}-1-public-1c"
  }
}

# Private Subnet 1a
resource "aws_subnet" "subnet-vpc-1-private-1a" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.1.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet-vpc-${var.shortnameid}-1-private-1a"
  }
}

# Private Subnet 1b
resource "aws_subnet" "subnet-vpc-1-private-1b" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.1.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "subnet-vpc-${var.shortnameid}-1-private-1b"
  }
}

# Private Subnet 1c
resource "aws_subnet" "subnet-vpc-1-private-1c" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.1.6.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "subnet-vpc-${var.shortnameid}-1-private-1c"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw-vpc-1" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "igw-vpc-${var.shortnameid}-1"
  }
}

# Router tables
resource "aws_default_route_table" "rt-vpc-1-default" {
  default_route_table_id = aws_vpc.vpc-1.default_route_table_id

  tags = {
    Name = "rt-vpc-${var.shortnameid}-1-default"
  }
}

resource "aws_route_table" "rt-vpc-1-public-subnets" {
  vpc_id = aws_vpc.vpc-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-vpc-1.id
  }

  tags = {
    Name = "rt-vpc-${var.shortnameid}-1-public-subnets"
  }
}

resource "aws_route_table" "rt-vpc-1-private-subnets" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "rt-vpc-${var.shortnameid}-1-private-subnets"
  }
}

# Router tables public subnets association
resource "aws_route_table_association" "rta-vpc-1-public-subnet-1a" {
  subnet_id      = aws_subnet.subnet-vpc-1-public-1a.id
  route_table_id = aws_route_table.rt-vpc-1-public-subnets.id
}
resource "aws_route_table_association" "rta-vpc-1-public-subnet-1b" {
  subnet_id      = aws_subnet.subnet-vpc-1-public-1b.id
  route_table_id = aws_route_table.rt-vpc-1-public-subnets.id
}
resource "aws_route_table_association" "rta-vpc-1-public-subnet-1c" {
  subnet_id      = aws_subnet.subnet-vpc-1-public-1c.id
  route_table_id = aws_route_table.rt-vpc-1-public-subnets.id
}


# Router tables private subnets association
resource "aws_route_table_association" "rta-vpc-1-private-subnet-1a" {
  subnet_id      = aws_subnet.subnet-vpc-1-private-1a.id
  route_table_id = aws_route_table.rt-vpc-1-private-subnets.id
}
resource "aws_route_table_association" "rta-vpc-1-private-subnet-1b" {
  subnet_id      = aws_subnet.subnet-vpc-1-private-1b.id
  route_table_id = aws_route_table.rt-vpc-1-private-subnets.id
}
resource "aws_route_table_association" "rta-vpc-1-private-subnet-1c" {
  subnet_id      = aws_subnet.subnet-vpc-1-private-1c.id
  route_table_id = aws_route_table.rt-vpc-1-private-subnets.id
}

# Security groups
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "sg-${var.shortnameid}-vpc-1-default"
  }
}

resource "aws_security_group" "sg-vpc-1-allow-all" {
  name        = "sg_${var.shortnameid}_vpc_1_allow_all"
  description = "Security group para permitir tudo"
  vpc_id      = aws_vpc.vpc-1.id

  ingress {
    description = "Permite tudo"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.shortnameid}-vpc-1-allow-all"
  }
}

resource "aws_security_group" "sg-vpc-1-alb-1-tgrp-1" {

  lifecycle {
    ignore_changes = [description]
  }

  name        = "sg_${var.shortnameid}_vpc_1_alb_1_tgrp_1"
  description = "Security group para instancias EC2 do Magento"
  vpc_id      = aws_vpc.vpc-1.id

  # ByPass
  ingress {
    description = "Permite tudo"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.shortnameid}-vpc-1-alb-1-tgrp-1"
  }
}

resource "aws_security_group" "sg-vpc-1-nlb-1-tgrp-1" {
  name        = "sg_${var.shortnameid}_redis_master_vpc_1_nlb_1_tgrp_1"
  description = "Security group para instancias EC2 do Redis Master"
  vpc_id      = aws_vpc.vpc-1.id

  # ByPass
  ingress {
    description = "Permite tudo"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.shortnameid}-redis-master-vpc-1-nlb-1-tgrp-1"
  }
}

resource "aws_security_group" "sg-vpc-1-nlb-2-tgrp-1" {
  name        = "sg_${var.shortnameid}_redis_replicas_vpc_1_nlb_2_tgrp_1"
  description = "Security group para instancias EC2 do Redis Replicas"
  vpc_id      = aws_vpc.vpc-1.id

  # ByPass
  ingress {
    description = "Permite tudo"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.shortnameid}-redis-replicas-vpc-1-nlb-2-tgrp-1"
  }
}

resource "aws_security_group" "sg-vpc-1-rds-1" {
  name        = "sg_${var.shortnameid}_vpc_1_rds_1"
  description = "Security group para o RDS"
  vpc_id      = aws_vpc.vpc-1.id

  # ByPass
  ingress {
    description = "Permite tudo"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow PostgreSQL access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.shortnameid}-vpc-1-rds-1"
  }
}

resource "aws_security_group" "sg-vpc-1-efs-1-mountpoints" {
  name        = "sg_${var.shortnameid}_vpc_1_efs_1_mountpoints"
  description = "Security group para os EFS 1 mount points"
  vpc_id      = aws_vpc.vpc-1.id

  # ByPass
  ingress {
    description = "Permite tudo"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow EFS access"
    from_port   = 2049
    to_port     = 2049
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.shortnameid}-vpc-1-efs-1-mountpoints"
  }
}

resource "aws_security_group" "sg-vpc-1-alb-1" {
  name        = "sg_${var.shortnameid}_vpc_1_alb_1"
  description = "Security group para o ALB 1"
  vpc_id      = aws_vpc.vpc-1.id

  # ByPass
  ingress {
    description = "Permite tudo"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS access"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.shortnameid}-vpc-1-alb-1"
  }
}

resource "aws_security_group" "sg-vpc-1-nlb-1" {
  name        = "sg_${var.shortnameid}_vpc_1_nlb_1"
  description = "Security group para o NLB 1, Redis Master"
  vpc_id      = aws_vpc.vpc-1.id

  # ByPass
  ingress {
    description = "Permite tudo"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.shortnameid}-vpc-1-nlb-1"
  }
}

resource "aws_security_group" "sg-vpc-1-nlb-2" {
  name        = "sg_${var.shortnameid}_vpc_1_nlb_2"
  description = "Security group para o NLB 1, Redis Replica"
  vpc_id      = aws_vpc.vpc-1.id

  # ByPass
  ingress {
    description = "Permite tudo"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.shortnameid}-vpc-1-nlb-2"
  }
}

resource "aws_security_group" "sg-vpc-1-opensearch-1" {
  name        = "sg_${var.shortnameid}_opensearch_1"
  description = "Security group para o Open Search 1"
  vpc_id      = aws_vpc.vpc-1.id

  # ByPass
  ingress {
    description = "Permite tudo"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.shortnameid}-opensearch-1"
  }
}

resource "aws_security_group" "sg-vpc-1-elasticcache-1" {
  name        = "sg_${var.shortnameid}elasticcache"
  description = "Security group para o elastic Cache 1"
  vpc_id      = aws_vpc.vpc-1.id

  # ByPass
  ingress {
    description = "Permite tudo"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.shortnameid}-elasticcache-1"
  }
}


resource "aws_security_group" "sg-vpc-1-allow-ssh-by-ip" {
  name        = "sg_${var.shortnameid}_vpc_1_allow_ssh_by_ip"
  description = "Security group para permitir conexao ssh por um ip especifico"
  vpc_id      = aws_vpc.vpc-1.id

  # ByPass
  ingress {
    description = "Permite tudo"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Permite conexao ssh por um ip especifico"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed-iplist
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.shortnameid}-vpc-1-allow-ssh-by-ip"
  }
}