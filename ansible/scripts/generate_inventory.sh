#!/bin/bash
# Gera o inventario do Ansible a partir dos outputs do Terraform

set -e

TERRAFORM_DIR="$(dirname "$0")/../../terraform"
INVENTORY_FILE="$(dirname "$0")/../inventory/hosts.ini"

# Pega o IP publico do Terraform
EC2_IP=$(terraform -chdir="$TERRAFORM_DIR" output -raw ec2_public_ip)

if [ -z "$EC2_IP" ]; then
  echo "ERRO: Nao foi possivel obter o IP da EC2 do Terraform"
  exit 1
fi

# Gera o arquivo de inventario
cat > "$INVENTORY_FILE" << EOF
[monitoring]
ec2-server ansible_host=$EC2_IP

[monitoring:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/infra-monitor-lab
EOF

echo "Inventario gerado com IP: $EC2_IP"