// EFS addons
resource "aws_efs_file_system" "efs-1" {
  creation_token  = "efs-${var.shortnameid}-1-token"
  encrypted       = true
  throughput_mode = "elastic"

  tags = {
    Name = "efs-${var.shortnameid}-1"
  }
}

resource "aws_efs_mount_target" "efs-1-mntpnt-subnet-private-1a" {
  file_system_id = aws_efs_file_system.efs-1.id
  subnet_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-private-1a-id
  security_groups = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-sg-vpc-1-efs-1-mountpoints-id
  ]
}

resource "aws_efs_mount_target" "efs-1-mntpnt-subnet-private-1b" {
  file_system_id = aws_efs_file_system.efs-1.id
  subnet_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-private-1b-id
  security_groups = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-sg-vpc-1-efs-1-mountpoints-id
  ]
}

resource "aws_efs_mount_target" "efs-1-mntpnt-subnet-private-1c" {
  file_system_id = aws_efs_file_system.efs-1.id
  subnet_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-private-1c-id
  security_groups = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-sg-vpc-1-efs-1-mountpoints-id
  ]
}

resource "aws_efs_backup_policy" "efs-1-backup-policy" {
  file_system_id = aws_efs_file_system.efs-1.id

  backup_policy {
    status = "DISABLED"
  }
}