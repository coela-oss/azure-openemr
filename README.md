# Terraform & Azure CLI Environment Setup

This project provides a Makefile to automate the setup and deployment of infrastructure on Azure using Terraform, with Ansible for configuration management.

---

## 📦 Prerequisites

Ensure your environment supports the following:

- Bash shell
- `make`
- Internet access for downloading dependencies

---

## 🚀 Quick Start

Run all setup steps at once:

```sh
make all
```

This executes:

1. Installing required tools (Azure CLI, Terraform, Ansible, Infracost)

2. Generating .env from .env.template

3. Initializing Terraform

4. Applying Terraform configuration to provision infrastructure

## 🛠️ Make Targets

```
make install-deps
```

Installs required tools:

* Ansible
* Azure CLI
* Terraform
* Infracost(Need Registration)

### Generates the .env file from .env.template.

```
make setup-env
```

### Displays the contents of the .env file.
```
make show-env
```
### Initializes the Terraform configuration located in the terraform directory.

```
make terraform-init
```

### Displays the Terraform execution plan without making changes.

```
make terraform-plan
```

### Uses Infracost to estimate the cost of your Terraform configuration.

```
make terraform-estimate
```

### Applies the Terraform configuration to provision the infrastructure.

```
make terraform-apply
```

### Destroys infrastructure that was provisioned with Terraform.

```
make terraform-destroy
```

### Generates the hosts.ini inventory file for Ansible based on Terraform outputs.
```
make ansible-generate-hosts
```

### Runs the Ansible playbook to install and configure MariaDB.

```
make ansible-run-playbook-mariadb
```

### Runs the Ansible playbook to install and configure OpenEMR.

```
make ansible-run-playbook-emr
```

### Deletes the .env file.

```
make clean
```

## 📝 Notes

Customize .env.template with values suited to your environment before running the setup.

Ensure your Azure account has the necessary permissions to provision resources.

Use the generated .env file to pass environment variables to Terraform and Ansible commands.

