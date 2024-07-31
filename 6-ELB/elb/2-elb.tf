// Target group
resource "aws_lb_target_group" "tgrp-1-alb-1" {

  name     = "tgrp-1-alb-${var.shortnameid}-1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-id

  stickiness {
    enabled         = true
    type            = "lb_cookie"
    cookie_duration = 3600
  }

  # stickiness {
  #   enabled     = true
  #   type        = "app_cookie"
  #   cookie_name = "PHPSESSID"
  # }

  health_check {
    enabled             = true
    protocol            = "HTTP"
    path                = "/health_check.php"
    port                = 80
    interval            = 20
    timeout             = 15
    healthy_threshold   = 2
    unhealthy_threshold = 5
    matcher             = "200"
  }

  deregistration_delay = 15

  tags = {
    Name = "tgrp-1-alb-${var.shortnameid}-1"
  }
}

// Application Load balancer
resource "aws_lb" "alb-1" {
  name               = "alb-${var.shortnameid}-1"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-sg-vpc-1-alb-1-id
  ]
  subnets = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-public-1a-id,
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-public-1b-id,
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-public-1c-id,
  ]

  enable_deletion_protection = false

  idle_timeout = 600

  tags = {
    Name = "alb-${var.shortnameid}-1"
  }
}

// Load balancer listeners
resource "aws_lb_listener" "listener-http-alb-1" {
  load_balancer_arn = aws_lb.alb-1.arn
  port              = "80"
  protocol          = "HTTP"

  # default_action {
  #   type             = "forward"
  #   target_group_arn = aws_lb_target_group.tgrp-alb-1.arn
  # }

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    Name = "listener-http-alb-${var.shortnameid}-1"
  }
}

resource "aws_lb_listener" "listener-https-alb-1" {
  load_balancer_arn = aws_lb.alb-1.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = data.terraform_remote_state.remote-ssl-certificate.outputs.acm-certificate-1-arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tgrp-1-alb-1.arn
  }

  tags = {
    Name = "listener-https-alb-${var.shortnameid}-1"
  }
}