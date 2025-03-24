output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "mariadb_nic_id" {
  value = azurerm_network_interface.dbnic.id
}

output "erm_nic_id" {
  value = azurerm_network_interface.ermnic.id
}


output "db_public_ip" {
  value = azurerm_public_ip.db_pip.ip_address
}

output "erm_public_ip" {
  value = azurerm_public_ip.erm_pip.ip_address
}
