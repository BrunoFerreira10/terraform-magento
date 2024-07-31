// Criar AMI
resource "aws_ami_from_instance" "ami" {
  name                    = "ami-terraform-${var.shortnameid}-v1"
  source_instance_id      = data.terraform_remote_state.remote-state-base-ec2.outputs.ec2-setup-ec2-setup-id
  snapshot_without_reboot = true

  tags = {
    Name = "ami-terraform-${var.shortnameid}-v1"
  }
}