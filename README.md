# azure-openemr

ローカル試験手順（Ubuntu / WSL 環境向け）
✅ 1. 依存ツールのインストール

# Terraform
```
sudo apt update && sudo apt install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
  | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

# Ansible

```
sudo apt install -y ansible
```

# jq (Terraform出力のパース用)
```
sudo apt install -y jq
```

✅ 2. .env ファイルを用意

```
cp .env.example .env
```

必要に応じて TF_VAR_db_password などの値を自分の環境に合わせて修正します。

✅ 3. .env を読み込む

# 環境変数として読み込む
```
export $(grep -v '^#' .env | xargs)
```
※ direnv を使って自動読み込みすると便利です。

✅ 4. Terraform 実行
```
cd terraform
```

# 初期化
```
terraform init
```

# 確認（問題なければ apply）
```
terraform plan
```

# 適用
```
terraform apply -auto-approve
```

✅ 5. 出力された VM の IP アドレスを確認

```
terraform output -raw vm_public_ip
```

✅ 6. Ansible の inventory を編集

```
# ansible/inventories/azure/hosts
[openemr]
openemr-vm ansible_host=<上で取得したIP> ansible_user=azureuser ansible_ssh_private_key_file=~/.ssh/id_rsa
````

✅ 7. Ansible Playbook 実行

```
cd ..
ansible-playbook -i ansible/inventories/azure ansible/site.yml
```

✅ 8. 動作確認（ブラウザ）

OpenEMRがデプロイされたサーバのIPにアクセス：

```
http://<VMのPublic IP>/openemr
```

✅ 補足（自動化のためにオススメ）

terraform output → hosts ファイルを自動生成するスクリプトを追加する

.env のチェック機構（読み込み失敗時の警告）をShellで入れる

Makefile でワンコマンド化する（例：make deploy）
