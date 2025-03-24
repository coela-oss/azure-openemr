# Makefile for Terraform & Azure CLI environment

ENV_FILE := .env
ENV_TEMPLATE := .env.template

.PHONY: all install-deps setup-env terraform-init terraform-apply terraform-destroy clean show-env ansible-generate-hosts

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


ansible-generate-hosts:
	@echo "Generating HOSTS for ansible from Terraform outputs..."
	@export $$(grep -v '^#' $(ENV_FILE) | xargs) && \
		./setup/ansible-generate-hosts.sh

ansible-run-playbook-mariadb:
	@echo "Running ansible playbook MariaDB..."
	@export $$(grep -v '^#' $(ENV_FILE) | xargs) && \
		ANSIBLE_ROLES_PATH=ansible/roles \
		ansible-playbook -i ansible/inventory/hosts.ini ansible/playbooks/mariadb.yml

ansible-run-playbook-emr:
	@echo "Running ansible playbook EMR..."
	@export $$(grep -v '^#' $(ENV_FILE) | xargs) && \
		ANSIBLE_ROLES_PATH=ansible/roles \
		ansible-playbook -i ansible/inventory/hosts.ini ansible/playbooks/openemr.yml


# === クリーンアップ ===
clean:
	rm -f $(ENV_FILE)