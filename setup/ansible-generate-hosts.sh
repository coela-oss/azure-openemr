#!/bin/bash

set -e

# Terraform出力（個別のoutput定義を想定）
mariadb_ip=$(terraform -chdir=terraform output -raw mariadb_public_ip)
mariadb_private_ip=$(terraform -chdir=terraform output -raw mariadb_private_ip)
emr_ip=$(terraform -chdir=terraform output -raw emr_public_ip)
emr_private_ip=$(terraform -chdir=terraform output -raw emr_private_ip)

# テンプレート読み込みと置換
template_file="ansible/inventory/hosts.ini.template"
output_file="ansible/inventory/hosts.ini"

cp "$template_file" "$output_file"

# プレースホルダの置換
sed -i "s|{mariadb_ip}|$mariadb_ip|g" "$output_file"
sed -i "s|{emr_ip}|$emr_ip|g" "$output_file"
sed -i "s|{mariadb_ssh_user}|$TF_VAR_mariadb_admin_username|g" "$output_file"
sed -i "s|{emr_ssh_user}|$TF_VAR_emr_admin_username|g" "$output_file"
sed -i "s|{ssh_private_key}|$ANSIBLE_ssh_private_key_path|g" "$output_file"
sed -i "s|{db_host}|$mariadb_private_ip|g" "$output_file"
sed -i "s|{emr_host}|$emr_private_ip|g" "$output_file"

echo "✅ ansible/inventory/hosts.ini generated successfully."
