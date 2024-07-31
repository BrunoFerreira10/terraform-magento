resource "aws_instance" "bastion-vpc-1" {
  # Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
  ami = "ami-04b70fa74e45c3917"

  #instance_type = "t3a.large"
  instance_type = "t3.micro"
  #key_name      = "aws-dev-console-admin"
  key_name  = "aws-services-ec2-ssh"
  subnet_id = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-public-1a-id

  vpc_security_group_ids = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-sg-vpc-1-allow-all-id
  ]
  associate_public_ip_address = true

  user_data_replace_on_change = true
  user_data = templatefile(
    "${path.module}/ec2-userdata.tftpl", {
      private_key_base64 = base64encode(var.AWS_SSH_PRIVATE_KEY)
    }
  )

  tags = {
    Name = "${var.shortnameid}-bastion-vpc-1"
  }
}



