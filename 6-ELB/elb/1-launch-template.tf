// Launch template 1
resource "aws_launch_template" "ltplt-1" {

  name                   = "ltplt-${var.shortnameid}-1"
  update_default_version = true

  // AMI
  image_id = data.terraform_remote_state.remote-ami.outputs.ami-ami-id

  // Instance type
  instance_type = "t3a.xlarge"  

  // Key pair (ec2 ssh login)  
  key_name = var.ec2-ssh-keypair-name

  iam_instance_profile {
    name = data.terraform_remote_state.remote-state-s3-static-files.outputs.s3-static-files-magento-ec2-s3-profile-name
  }

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

