output "vm_public_ip_address" {
  value = data.azurerm_public_ip.vm.ip_address
}
