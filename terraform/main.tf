
module "core" {
  source              = "./modules/core"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = module.core.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  allowed_ssh_ips = var.allowed_ssh_ips
  erm_vm_name = var.erm_vm_name
  mariadb_vm_name = var.mariadb_vm_name
  depends_on = [ module.core ]
}


module "erm" {
  source              = "./modules/erm"
  resource_group_name = module.core.resource_group_name
  location            = var.location
  admin_username          = var.erm_admin_username
  admin_password      = var.erm_admin_password
  vm_name = var.erm_vm_name
  vm_size = var.erm_vm_size
  nic_id = module.network.erm_nic_id
  ssh_public_key_path = var.ssh_public_key_path
  depends_on = [ module.network ]
}

module "mariadb" {
  source              = "./modules/mariadb"
  resource_group_name = module.core.resource_group_name
  location            = var.location
  admin_username          = var.mariadb_admin_username
  admin_password      = var.mariadb_admin_password
  vm_name = var.mariadb_vm_name
  vm_size = var.mariadb_vm_size
  nic_id = module.network.mariadb_nic_id
  ssh_public_key_path = var.ssh_public_key_path
  depends_on = [ module.network ]
}
