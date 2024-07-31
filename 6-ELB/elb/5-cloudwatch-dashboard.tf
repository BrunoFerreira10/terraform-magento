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