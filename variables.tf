variable "region" { type = string }
variable "aws_profile" { type = string }
variable "env_name" { type = string }

variable "vpc_cidr" { type = string }
variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }

variable "allowed_http_cidr" { type = string }
variable "allowed_mysql_cidr" { type = string }

variable "instance_type" { type = string }

variable "use_rds" { type = bool }
variable "db_root_password" { type = string, sensitive = true, default = null }
variable "db_name" { type = string }
variable "db_user" { type = string }
variable "db_password" { type = string, sensitive = true }

variable "db_instance_class" { type = string, default = null }
variable "db_allocated_storage" { type = number, default = null }
variable "db_engine_version" { type = string, default = null }

variable "ubuntu_owner" { type = string }
