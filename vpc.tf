resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = merge(local.common_tags, { Name = "${var.env_name}-vpc" })
}

resource "aws_subnet" "public" {
  for_each = local.public_subnets_map
  vpc_id = aws_vpc.main.id
  cidr_block = each.value
  map_public_ip_on_launch = true
  availability_zone = "${var.region}${each.key}"
  tags = merge(local.common_tags, { Name = "${var.env_name}-public-${each.key}" })
}

resource "aws_subnet" "private" {
  for_each = local.private_subnets_map
  vpc_id = aws_vpc.main.id
  cidr_block = each.value
  map_public_ip_on_launch = false
  availability_zone = "${var.region}${each.key}"
  tags = merge(local.common_tags, { Name = "${var.env_name}-private-${each.key}" })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(local.common_tags, { Name = "${var.env_name}-igw" })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route { cidr_block="0.0.0.0/0"; gateway_id=aws_internet_gateway.igw.id }
  tags = merge(local.common_tags, { Name = "${var.env_name}-public-rt" })
}

resource "aws_route_table_association" "public_assoc" {
  for_each = aws_subnet.public
  subnet_id = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.main.id
  name = "${var.env_name}-sg"

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.cidr]
    }
  }

  egress {
    from_port=0; to_port=0; protocol="-1"; cidr_blocks=["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "${var.env_name}-sg" })
}
