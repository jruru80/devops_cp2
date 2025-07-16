# Red virtual 
resource "azurerm_virtual_network" "virtual_network" {
  name                = var.network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  tags = {
    environment = "CP2"
  }
}

# Subred, necesaria para 
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "network_interface" {
  name                = var.nic_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.10"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
  depends_on = [
    azurerm_public_ip.public_ip
  ]

  tags = {
    environment = "casopractico2"
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "public_ip"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard" # Si no usaba estos valores obtenia 
  #Cannot create more than 0 IPv4 Basic SKU public IP addresses for this subscription in this region

  tags = {
    environment = "casopractico2"
  }
}

data "azurerm_public_ip" "virtual_machine" {
  name                = azurerm_public_ip.public_ip.name
  resource_group_name = azurerm_resource_group.resource_group.name

  depends_on = [
    azurerm_linux_virtual_machine.virtual_machine
  ]
}