output "mariadb_public_ip" {
  value = module.network.db_public_ip
}

output "emr_public_ip" {
  value = module.network.emr_public_ip
}