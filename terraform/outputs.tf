output "ec2_public_ip" {
  description = "IP público da EC2"
  value       = module.ec2.public_ip
}

output "ec2_public_dns" {
  description = "DNS público da EC2"
  value       = module.ec2.public_dns
}

output "vpc_id" {
  description = "ID da VPC criada"
  value       = module.vpc.vpc_id
}
