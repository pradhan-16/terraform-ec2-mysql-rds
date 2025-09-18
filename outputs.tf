output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}

output "rds_endpoint" {
  value = var.use_rds ? aws_db_instance.mydb[0].endpoint : "Local MySQL on EC2"
}
