output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}

output "web_app_url" {
  value = "http://${aws_instance.web.public_ip}"
}

output "db_check_url" {
  value = "http://${aws_instance.web.public_ip}/db-check"
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.address
}

output "session_manager_instance_id" {
  value = aws_instance.web.id
}
