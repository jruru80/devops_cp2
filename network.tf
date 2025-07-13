# Red virtual 
resource "azurerm_virtual_network" "cp2" {
  name                = var.network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.cp2.location
  resource_group_name = azurerm_resource_group.cp2.name

  tags = {
    environment = "CP2"
  }
}

# Subred, necesaria para 
resource "azurerm_subnet" "cp2" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.cp2.name
  virtual_network_name = azurerm_virtual_network.cp2.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "cp2" {
  name                = var.nic_name
  location            = azurerm_resource_group.cp2.location
  resource_group_name = azurerm_resource_group.cp2.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.cp2.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.10"
    public_ip_address_id          = azurerm_public_ip.cp2.id
  }
  depends_on = [
    azurerm_public_ip.cp2
  ]

  tags = {
    environment = "CP2"
  }
}

resource "azurerm_public_ip" "cp2" {
  name                = "public_ip"
  location            = azurerm_resource_group.cp2.location
  resource_group_name = azurerm_resource_group.cp2.name
  allocation_method   = "Static"
  sku                 = "Standard" # Si no usaba estos valores obtenia 
  #Cannot create more than 0 IPv4 Basic SKU public IP addresses for this subscription in this region

  tags = {
    environment = "CP2"
  }
}

data "azurerm_public_ip" "cp2" {
  name                = azurerm_public_ip.cp2.name
  resource_group_name = azurerm_resource_group.cp2.name

  depends_on = [
    azurerm_linux_virtual_machine.cp2
  ]
}