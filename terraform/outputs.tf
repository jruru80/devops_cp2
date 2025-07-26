#Aqui se obtienen las salidas de las infraestructuras creadas con terraform.

# Nombre del ACR generado aleatoriamente.
output "acr_hostname" {
  value = "${azurerm_container_registry.acr.name}.azurecr.io"
}

# Nombre del usuario ACR.
output "acr_username" {
  value = azurerm_container_registry.acr.admin_username
}
# Contraseña del ACR. Al estar marcada como sensitive, se considera 
# sensible y no se muestra en la salida normal.
output "acr_password" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}

#Nombre de la maguina virtual creada.
output "vm_id" {
  value = azurerm_linux_virtual_machine.virtual_machine.id
}
#Direccion IP pública de la máquina virtual.
output "vm_public_ip_address" {
  value = data.azurerm_public_ip.virtual_machine.ip_address
}

#La clave privada SSH generada para la máquina virtual.
# Se marca como sensitive para no mostrarla en la salida normal.
output "private_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

# La clave pública SSH generada para la máquina virtual.
# Se marca como sensitive para no mostrarla en la salida normal.
output "public_key" {
  value     = tls_private_key.ssh_key.public_key_openssh
  sensitive = true
}