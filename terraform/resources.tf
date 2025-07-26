# Resource group de azure, de donde cuelgan los recursos creados
# De esta forma es más fácil gestionar los recursos y eliminarlos a la vez 
# Utilizando terraform destroy
# En mi caso, el nombre del grupo de recursos es "casopractico2"
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location_name

  tags = {
    environment = "casopractico2"
  }
}

# Crea un grupo de seguridad de red para permitir el tráfico SSH a la máquina virtual.
# Permite el acceso a la máquina virtual a través del puerto 22 (SSH).
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

