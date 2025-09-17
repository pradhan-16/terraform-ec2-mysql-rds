locals {
  common_tags = {
    Environment = var.env_name
    ManagedBy   = "Terraform"
  }

  public_subnets_map = { for idx, cidr in var.public_subnet_cidrs : idx => cidr }
  private_subnets_map = { for idx, cidr in var.private_subnet_cidrs : idx => cidr }

  ingress_rules = [
    { from=80, to=80, protocol="tcp", cidr=var.allowed_http_cidr },
    { from=3306, to=3306, protocol="tcp", cidr=var.allowed_mysql_cidr }
  ]
}
