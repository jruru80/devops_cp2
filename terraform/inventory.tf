#crea el inventorio dinamico
#
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