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
    interval            = 60
    timeout             = 20
    healthy_threshold   = 2
    unhealthy_threshold = 3
    matcher             = "200-404"
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

// Auto-scaling
resource "aws_autoscaling_group" "asg-alb-1" {

  // Group Details  
  capacity_rebalance = true
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  lifecycle {
    create_before_destroy = true
  }

  // Launch template
  launch_template {
    id      = aws_launch_template.ltplt-1.id
    version = "$Latest"
  }

  // Network
  vpc_zone_identifier = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-private-1a-id,
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-private-1b-id,
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-private-1c-id,
  ]

  // Load balancing
  target_group_arns = [
    aws_lb_target_group.tgrp-1-alb-1.arn
  ]

  // Health checks
  # health_check_type         = "ELB"
  health_check_type         = "EC2"
  health_check_grace_period = 60

  // Advanced configuration
  default_cooldown = 180

  // Metrics
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

}