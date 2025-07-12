resource "azurerm_resource_group" "vm" {
  name     = var.resource_group_name
  location = var.location_name
}

resource "azurerm_virtual_network" "vm" {
  name                = var.network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name
}

resource "azurerm_subnet" "vm" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.vm.name
  virtual_network_name = azurerm_virtual_network.vm.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "vm" {
  name                = var.nic_name
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm.id
  }
  depends_on = [
    azurerm_public_ip.vm
  ]
}

resource "azurerm_public_ip" "vm" {
  name                = "public_ip"
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

data "azurerm_public_ip" "vm" {
  name                = azurerm_public_ip.vm.name
  resource_group_name = azurerm_resource_group.vm.name
  depends_on = [
    azurerm_linux_virtual_machine.vm
  ]
}