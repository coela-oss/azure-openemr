#!/bin/bash
set -e

# システムを最新化
sudo apt update && sudo apt upgrade -y

# 必要なパッケージのインストール
sudo apt install -y ca-certificates curl apt-transport-https lsb-release gnupg

# MicrosoftのGPGキーをインポート
curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
  gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

# Azure CLIリポジトリを追加
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
  sudo tee /etc/apt/sources.list.d/azure-cli.list

# Azure CLIのインストール
sudo apt update
sudo apt install -y azure-cli

# バージョン確認
az version
