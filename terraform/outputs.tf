output "mariadb_public_ip" {
  value = module.network.db_public_ip
}

output "erm_public_ip" {
  value = module.network.erm_public_ip
}