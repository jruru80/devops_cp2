#Recurso de Azure que contiene la máquina virtual.
# Se define el tamaño, la ubicación, el tipo de imagen (Ubuntu)
# el nombre de usuario administrador y la clave SSH.
# Se conecta a la interfaz de red creada anteriormente y
# Se utiliza una clave SSH para la autenticación.
resource "azurerm_linux_virtual_machine" "virtual_machine" {
  name                  = "vm-cp2"
  resource_group_name   = var.resource_group_name
  location              = var.location_name
  size                  = "Standard_B1s"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.network_interface.id]
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
# Crea una clave SSH para la máquina virtual.
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}