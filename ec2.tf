data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = [var.ubuntu_owner]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "tls_private_key" "mykey" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "mykey" {
  key_name   = "terraform-key-${var.env_name}"
  public_key = tls_private_key.mykey.public_key_openssh
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public["0"].id
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = aws_key_pair.mykey.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_ssm_profile.name

  user_data = templatefile("${path.module}/userdata/userdata.sh", {
    env_name        = var.env_name
    use_rds         = var.use_rds
    db_name         = var.db_name
    db_user         = var.db_user
    db_password     = var.db_password
    rds_ssm_param   = var.rds_ssm_parameter
  })

  tags = merge(local.common_tags, { Name = "${var.env_name}-ec2" })
}
