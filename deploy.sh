#!/bin/bash
# Deploy completo: Terraform + Ansible
# Uso: ./deploy.sh

set -e

PROJECT_DIR="$(dirname "$(readlink -f "$0")")"

echo "==> 1/3 Aplicando infraestrutura com Terraform"
cd "$PROJECT_DIR/terraform"
terraform apply -var-file="terraform.tfvars" -auto-approve

echo ""
echo "==> 2/3 Gerando inventario dinamico do Ansible"
"$PROJECT_DIR/ansible/scripts/generate_inventory.sh"

echo ""
echo "==> 3/3 Configurando EC2 com Ansible"
cd "$PROJECT_DIR/ansible"
ansible-playbook playbooks/site.yml

echo ""
echo "==> Deploy concluido com sucesso"
echo ""
echo "URLs disponiveis:"
EC2_IP=$(terraform -chdir="$PROJECT_DIR/terraform" output -raw ec2_public_ip)
echo "  API:        http://$EC2_IP:5000"
echo "  Prometheus: http://$EC2_IP:9090"
echo "  Grafana:    http://$EC2_IP:3000"
