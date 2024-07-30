
resource "aws_opensearch_domain" "opensearch-1" {

  domain_name = "opensearch-${var.shortnameid}-1"

  cluster_config {
    # instance_type = "t3.small.search"
    instance_type = "t3.medium.search"
    instance_count           = 1
    # dedicated_master_enabled = true
    # dedicated_master_type    = "t3.small.search"
    # dedicated_master_count   = 1
    # zone_awareness_enabled   = true
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
    volume_type = "gp3"
  }

  vpc_options {
    subnet_ids = [
      data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-private-1a-id
    ]
    security_group_ids = [
      data.terraform_remote_state.remote-state-vpc.outputs.vpcs-sg-vpc-1-opensearch-1-id
    ]
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  node_to_node_encryption {
    enabled = true
  }

  encrypt_at_rest {
    enabled = true
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  off_peak_window_options {
    off_peak_window {
      window_start_time {
        hours   = 09
        minutes = 00
      }
    }
  }

  # access_policies = jsonencode({
  #   Version = "2012-10-17",
  #   Statement = [
  #     {
  #       Effect = "Allow",
  #       Principal = {
  #         AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${aws_iam_role.opensearch_access_role.name}"
  #       },
  #       Action = "es:*",
  #       Resource = "arn:aws:es:us-east-1:${data.aws_caller_identity.current.account_id}:domain/opensearch-${var.shortnameid}-1/*"
  #     }
  #   ]
  # })

  access_policies = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "es:*",
        "Resource" : "arn:aws:es:us-east-1:${data.aws_caller_identity.current.account_id}:domain/opensearch-${var.shortnameid}-1/*"
      }
    ]
  })

  tags = {
    Name = "opensearch-${var.shortnameid}-1"
  }

}