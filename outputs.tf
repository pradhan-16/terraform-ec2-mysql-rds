output "ec2_instance_id" { value=aws_instance.web.id }
output "ec2_public_ip"   { value=aws_instance.web.public_ip }

output "rds_endpoint" {
  value = var.use_rds ? aws_db_instance.mydb[0].endpoint : "No RDS in Dev"
}
