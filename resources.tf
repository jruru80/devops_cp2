# Resource group de azure, de donde cuelgan los recursos
resource "azurerm_resource_group" "vm" {
  name     = var.resource_group_name
  location = var.location_name

  tags = {
    environment = "CP2"
  }
}

resource "azurerm_network_security_group" "cp2SecGroup" {
  name                = "sshtraffic"
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "CP2"
  }
}

