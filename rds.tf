resource "aws_db_subnet_group" "db_subnet_group" {
  count = var.use_rds ? 1 : 0
  name  = "${var.env_name}-db-subnet-group"
  subnet_ids = [for s in aws_subnet.private : s.id]
  tags = merge(local.common_tags, { Name="${var.env_name}-db-subnet-group" })
}

resource "aws_db_instance" "mydb" {
  count = var.use_rds ? 1 : 0
  identifier = "${var.env_name}-rds"
  engine = "mysql"
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  username = var.db_user
  password = var.db_password
  skip_final_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group[0].name
  vpc_security_group_ids = [aws_security_group.sg.id]
  publicly_accessible = true
  tags = merge(local.common_tags, { Name="${var.env_name}-rds" })
}
