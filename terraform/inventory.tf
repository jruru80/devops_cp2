#crea el inventorio dinamico
# Se utilizara para Ansible, (ver README.md)
# Utiliza el template inventory.tmpl para generar el contenido del inventario
# y la IP de la VM creada en el archivo virtual_machine.tf
# y el nombre de usuario del ACR.
resource "local_file" "ansible_inventory" {

  depends_on = [azurerm_linux_virtual_machine.virtual_machine]

  content = templatefile("inventory.tmpl",
    {
      vm_ip        = data.azurerm_public_ip.virtual_machine.ip_address
      acr_username = azurerm_container_registry.acr.admin_username
    }
  )
  filename = "inventory"
}