
# Shared Settings
variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}


variable "allowed_ssh_ips" {
  type        = list(string)
  default     = []
}

variable "ssh_public_key_path" {
  type        = string
}


# MariaDB
variable "mariadb_vm_name" {
  default = "mariadb-vm"
}

variable "mariadb_vm_size" {
  description = "MariaDB Azure VM size"
  type        = string
  default     = "Standard_B2ms"
}

variable "mariadb_admin_username" {
  default = "adminuser"
}

variable "mariadb_admin_password" {
  sensitive = true
}

# OpenERM
variable "erm_vm_name" {
  default = "erm-vm"
}

variable "erm_vm_size" {
  description = "OpenERM Azure VM size"
  type        = string
  default     = "Standard_B2ms"
}

variable "erm_admin_username" {
  default = "adminuser"
}

variable "erm_admin_password" {
  sensitive = true
}
