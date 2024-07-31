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