# Makefile for Terraform & Azure CLI environment

ENV_FILE := .env
ENV_TEMPLATE := .env.template

.PHONY: all install-deps setup-env terraform-init terraform-apply terraform-destroy clean show-env

# === 初期化処理（全体実行） ===
all: install-deps setup-env terraform-init terraform-apply

# === 必要なパッケージのインストール ===
install-deps:
	@echo "Installing Azure CLI and Terraform if needed..."
	./setup/install-ansible.sh
	./setup/install-azurecli.sh
	./setup/install-terraform.sh
	./setup/install-infracost.sh

setup-env:
	@echo "Generating .env from template..."
	@./setup/setup-envs.sh

# === .env を表示 ===
show-env:
	@echo "Current environment variables:"
	@cat $(ENV_FILE)

# === Terraform 初期化 ===
terraform-init:
	@echo "Running terraform init..."
	@export $$(grep -v '^#' $(ENV_FILE) | xargs) && \
		terraform -chdir=terraform init 

# === Terraform 初期化 ===
terraform-plan:
	@echo "Running terraform plan..."
	@export $$(grep -v '^#' $(ENV_FILE) | xargs) && \
		terraform -chdir=terraform plan

terraform-estimate:
	@echo "Running terraform plan..."
	@infracost breakdown --path terraform

# === Terraform 適用 ===
terraform-apply:
	@echo "Running terraform apply..."
	@export $$(grep -v '^#' $(ENV_FILE) | xargs) && \
		terraform -chdir=terraform apply -auto-approve


# === Terraform 削除 ===
terraform-destroy:
	@echo "Running terraform destroy..."
	@export $$(grep -v '^#' $(ENV_FILE) | xargs) && \
		terraform -chdir=terraform destroy


# === クリーンアップ ===
clean:
	rm -f $(ENV_FILE)