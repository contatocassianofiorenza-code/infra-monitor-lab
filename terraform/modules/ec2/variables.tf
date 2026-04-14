variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet pública"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "IP autorizado a acessar a EC2 (seu IP com /32)"
  type        = string
}

variable "public_key_path" {
  description = "Caminho da chave pública SSH"
  type        = string
  default     = "~/.ssh/infra-monitor-lab.pub"
}

variable "ami_id" {
  description = "ID da AMI Ubuntu"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t3.micro"
}
