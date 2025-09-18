locals {
  common_tags = {
    Environment = var.env_name
  }

  public_subnets_map  = { for idx, cidr in var.public_subnet_cidrs : idx => cidr }
  private_subnets_map = { for idx, cidr in var.private_subnet_cidrs : idx => cidr }

  ingress_rules = [
    { from = 22, to = 22, protocol = "tcp", cidr = var.allowed_http_cidr },    # SSH
    { from = 80, to = 80, protocol = "tcp", cidr = var.allowed_http_cidr },    # HTTP
    { from = 3306, to = 3306, protocol = "tcp", cidr = var.allowed_mysql_cidr } # MySQL
  ]
}
