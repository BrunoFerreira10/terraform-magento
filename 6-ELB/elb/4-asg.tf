resource "aws_autoscaling_policy" "cpu-limit-add-instance" {
  name                   = "cpu-limit-add-instance"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.asg-alb-1.name
}

resource "aws_autoscaling_policy" "cpu-limit-remove-instance" {
  name                   = "cpu-limit-remove-instance"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.asg-alb-1.name
}

// Auto-scaling group
resource "aws_autoscaling_group" "asg-alb-1" {

  // Group Details  
  capacity_rebalance = true
  desired_capacity   = 1  
  min_size           = 1
  max_size           = 4

  lifecycle {
    create_before_destroy = true
  }

  // Launch template
  launch_template {
    id      = aws_launch_template.ltplt-1.id
    version = aws_launch_template.ltplt-1.latest_version
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
  health_check_type         = "ELB"
  # health_check_type         = "EC2"
  health_check_grace_period = 60

  // Advanced configuration
  default_cooldown = 60

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 100
      max_healthy_percentage = 110
      skip_matching = true
    }
  }

  warm_pool {
    min_size = 1
    max_group_prepared_capacity = 1
    pool_state = "Stopped" #"Hibernated"
    
    instance_reuse_policy {
      reuse_on_scale_in = false
    }
  }  

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