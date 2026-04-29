#!/bin/bash
# Destroi toda a infraestrutura

set -e

PROJECT_DIR="$(dirname "$(readlink -f "$0")")"

echo "==> Destruindo infraestrutura"
cd "$PROJECT_DIR/terraform"
terraform destroy -var-file="terraform.tfvars" -auto-approve

echo ""
echo "==> Infraestrutura destruida"
