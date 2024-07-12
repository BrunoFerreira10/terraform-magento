// Launch template 1
resource "aws_launch_template" "ltplt-1" {

  name                   = "ltplt-${var.shortnameid}-1"
  update_default_version = true

  // AMI
  image_id = data.terraform_remote_state.remote-ami.outputs.ami-ami-id

  // Instance type
  instance_type = "c7a.medium"

  // Key pair (login)
  key_name = "aws-dev-console-admin"

  // Network settings
  vpc_security_group_ids = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-sg-vpc-1-alb-1-tgrp-1-id
  ]

  // Resource tags
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ltplt-${var.shortnameid}-1"
    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      Name = "ltplt-${var.shortnameid}-1-ebs"
    }
  }

  tag_specifications {
    resource_type = "network-interface"

    tags = {
      Name = "ltplt-${var.shortnameid}-1-eni"
    }
  }

  // Advanced details
  instance_initiated_shutdown_behavior = "terminate"

  monitoring {
    enabled = true
  }  

  // ebs_optimized = true

  tags = {
    Name = "ltplt-${var.shortnameid}-1"
  }
}

