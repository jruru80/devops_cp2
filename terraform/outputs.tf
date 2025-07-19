output "acr_hostname" {
  value = "${azurerm_container_registry.acr.name}.azurecr.io"
}


output "acr_username" {
  value = azurerm_container_registry.acr.admin_username
}
output "acr_password" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.virtual_machine.id
}

output "vm_public_ip_address" {
  value = data.azurerm_public_ip.virtual_machine.ip_address
}

output "private_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

output "public_key" {
  value     = tls_private_key.ssh_key.public_key_openssh
  sensitive = true
}