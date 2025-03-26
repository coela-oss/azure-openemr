# Terraform & Azure CLI Environment Setup

This project provides a Makefile to automate the setup and deployment of infrastructure on Azure using Terraform, with Ansible for configuration management.

---

## 📦 Prerequisites

Ensure your environment supports the following:

- Bash shell (WSL Ubuntu22)
- `make`
- Internet access for downloading dependencies
- Register Infracost (Optional)

---

## 🚀 Quick Start

### Setup Azure Cloud Infrastructures

```sh
make azure
```

This executes:

1. Installing required tools (Azure CLI, Terraform, Ansible, Infracost)
2. Generating .env from .env.template
3. Initializing Terraform
4. Applying Terraform configuration to provision infrastructure

### Domain routing

If you need, set Public IP Address to your Domain Provider with the terraform output variables.


### Run Ansible Playbook

```sh
make emr
```

This executes:

1. Installing packages (MariaDB, Nginx, PHP, OpenEMR)
2. Generate `hosts.ini` for each server.
3. Let's Encrypt server certification(Optional when set `ANSIBLE_nginx_domain` and `ANSIBLE_nginx_letsencrypt_email`)
4. Auto install OpenEMR.


## 📝 Notes

Customize .env.template with values suited to your environment before running the setup.

Ensure your Azure account has the necessary permissions to provision resources.

Use the generated .env file to pass environment variables to Terraform and Ansible commands.

