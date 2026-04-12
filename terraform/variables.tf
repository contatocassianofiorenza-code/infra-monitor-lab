variable "aws_region" {
  description = "Região da AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto usado para nomear os recursos"
  type        = string
  default     = "infra-monitor-lab"
}

variable "environment" {
  description = "Ambiente do projeto"
  type        = string
  default     = "lab"
}
