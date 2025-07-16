# Resource group de azure, de donde cuelgan los recursos
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location_name

  tags = {
    environment = "casopractico2"
  }
}

resource "azurerm_network_security_group" "security_group" {
  name                = "sshtraffic"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

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
    environment = "casopractico2"
  }
}

