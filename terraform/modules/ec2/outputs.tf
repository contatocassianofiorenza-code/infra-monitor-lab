output "instance_id" {
  description = "ID da instância EC2"
  value       = aws_instance.main.id
}

output "public_ip" {
  description = "IP público da EC2"
  value       = aws_eip.main.public_ip
}

output "public_dns" {
  description = "DNS público da EC2"
  value       = aws_instance.main.public_dns
}
