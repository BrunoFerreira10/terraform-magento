// Network Load balancer
resource "aws_lb" "nlb-1" {
  name               = "nlb-redis-${var.shortnameid}-1"
  internal           = false
  load_balancer_type = "network"
  security_groups = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-sg-vpc-1-nlb-1-id
  ]
  subnets = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-public-1a-id,
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-public-1b-id
  ]

  enable_deletion_protection = false

  tags = {
    Name = "nlb-redis-${var.shortnameid}-1"
  }
}

// Load balancer listener - Redis master
resource "aws_lb_listener" "listener-tcp-tgrp-1-nlb-1" {
  load_balancer_arn = aws_lb.nlb-1.arn
  port              = "6379"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tgrp-1-nlb-1.arn
  }  

  tags = {
    Name = "listener-tcp-nlb-${var.shortnameid}-1-tgrp-redis-master-1-nlb-1"
  }
}

// Load balancer listener - Redis replicas
resource "aws_lb_listener" "listener-tcp-tgrp-2-nlb-1" {
  load_balancer_arn = aws_lb.nlb-1.arn
  port              = "6379"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tgrp-2-nlb-1.arn
  }  

  tags = {
    Name = "listener-tcp-nlb-${var.shortnameid}-1-tgrp-redis-replica-2-nlb-1"
  }
}