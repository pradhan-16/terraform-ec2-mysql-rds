data "aws_ami" "ubuntu" {
  most_recent = true
  owners = [var.ubuntu_owner]
  filter { name="name"; values=["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"] }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = values(aws_subnet.public)[0].id
  vpc_security_group_ids = [aws_security_group.sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_ssm_profile.name

  user_data = templatefile("${path.module}/userdata/userdata.sh", {
    env_name         = var.env_name
    use_rds          = var.use_rds
    db_root_password = var.db_root_password
    db_name          = var.db_name
    db_user          = var.db_user
    db_password      = var.db_password
  })

  tags = merge(local.common_tags, { Name = "${var.env_name}-ec2" })
}
