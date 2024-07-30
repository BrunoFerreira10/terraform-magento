resource "aws_cloudwatch_metric_alarm" "alarm-cpu-bigger-than-limit" {
  alarm_name          = "cpu-bigger-than-limit"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 10
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Uso da CPU maior que o limite."

  # dimensions = {
  #   LoadBalancer = aws_lb.alb-1.arn_suffix
  # }

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg-alb-1.name
  }

  alarm_actions = [
    aws_autoscaling_policy.cpu-limit-add-instance.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "alarm-cpu-lower-than-limit" {
  alarm_name          = "cpu-lower-than-limit"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 30
  alarm_description   = "Uso da CPU menor que o limite."

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg-alb-1.name
  }

  alarm_actions = [
    aws_autoscaling_policy.cpu-limit-remove-instance.arn
  ]
}

resource "aws_cloudwatch_dashboard" "dashboard-1" {
  dashboard_name = "Magento-Dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 1

        properties = {
          markdown = "## Magento Dashboard"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 1
        width  = 6
        height = 4

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "AutoScalingGroupName",
              aws_autoscaling_group.asg-alb-1.name
            ]
          ]
          period = 60
          stat   = "Average"
          region = "us-east-1"
          title  = "Auto Scaling Group - CPU Utilization"
        }
      },
      {
        type   = "metric"
        x      = 6
        y      = 1
        width  = 6
        height = 4

        properties = {
          metrics = [
            [
              "AWS/AutoScaling",
              "GroupTotalInstances",
              "AutoScalingGroupName",
              aws_autoscaling_group.asg-alb-1.name
            ]
          ]
          period = 60
          stat   = "Sum"
          region = "us-east-1"
          title  = "Auto Scaling Group - Group Total Instances"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 1
        width  = 6
        height = 4

        properties = {
          title  = "ELB - Requests"
          region = "us-east-1"
          stat   = "Sum"
          period = 60
          metrics = [
            [
              "AWS/ApplicationELB",
              "RequestCount",
              "TargetGroup",
              aws_lb_target_group.tgrp-1-alb-1.arn_suffix,
              "LoadBalancer",
              aws_lb.alb-1.arn_suffix
            ]
          ]
        }
      }
      ,
      {
        type   = "metric"
        x      = 18
        y      = 1
        width  = 6
        height = 4

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "NetworkIn",
              "AutoScalingGroupName",
              aws_autoscaling_group.asg-alb-1.name
            ]
          ]
          period = 60
          stat   = "Average"
          region = "us-east-1"
          title  = "Auto Scaling Group - Network In"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 7
        width  = 6
        height = 4

        properties = {
          title  = "Redis - Node Current Connections"
          region = "us-east-1"
          stat   = "Average"
          period = 60
          metrics = [
            [
              "AWS/ElastiCache",
              "CurrConnections",
              "CacheClusterId",
              data.terraform_remote_state.remote-state-elasticcache.outputs.elasticcache-elasticcache-1-cluster-id,
              "CacheNodeId",
              "0001"
            ]
          ]
        }
      }
    ]
  })
}