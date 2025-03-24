#!/bin/bash

set -e

SUBSCRIPTION_ID=$(az account show --query id -o tsv)
TENANT_ID=$(az account show --query tenantId -o tsv)

SSH_DIR="~/.ssh"
KEY_NAME="id_rsa"
mkdir -p "$SSH_DIR"

if [ ! -f "$SSH_DIR/$KEY_NAME" ]; then
  ssh-keygen -t rsa -b 4096 -f "$SSH_DIR/$KEY_NAME" -N ""
  echo "✅ Generate SSH Key File: $SSH_DIR/$KEY_NAME"
else
  echo "ℹ️ Use the SSH Key exists: $SSH_DIR/$KEY_NAME"
fi
PUB_KEY_PATH="$(cd "$SSH_DIR" && pwd)/${KEY_NAME}.pub"

PUBLIC_IP=$(curl -s https://api.ipify.org)

sed \
  -e "s|__SUBSCRIPTION_ID__|$SUBSCRIPTION_ID|" \
  -e "s|__TENANT_ID__|$TENANT_ID|" \
  -e "s|__ALLOWED_SSH_IPS__|'[\"$PUBLIC_IP\"]'|" \
  -e "s|__SSH_PUBLIC_KEY_PATH__|$PUB_KEY_PATH|" \
  .env.template > .env

echo ".env generated:"
cat .env
