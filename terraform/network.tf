# Crea una red virtual en Azure.
# Esta red virtual se utilizará para la máquina virtual y el AKS.
# Define una dirección de espacio de direcciones y un 
# nombre para la red virtual que permite la comunicación entre recursos.
resource "azurerm_virtual_network" "virtual_network" {
  name                = var.network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  tags = {
    environment = "CP2"
  }
}

# Subred, necesaria para la máquina virtual y el AKS.
# Se define una subred dentro de la red virtual creada anteriormente.
# Se utiliza para la comunicación entre recursos dentro de la red virtual.
# La subred se asigna a la máquina virtual y al AKS.
# La IP pública se asigna a la interfaz de red de la máquina virtual.
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Crea una interfaz de red para la máquina virtual.
# Esta interfaz de red se conecta a la subred creada anteriormente.
# Se asigna una IP pública a la interfaz de red para permitir el acceso a la máquina 
# virtual desde Internet.
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

# Crea una IP pública para la máquina virtual.
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
# Obtiene la IP pública de la máquina virtual. Creada en vm.tf.
data "azurerm_public_ip" "virtual_machine" {
  name                = azurerm_public_ip.public_ip.name
  resource_group_name = azurerm_resource_group.resource_group.name

  depends_on = [
    azurerm_linux_virtual_machine.virtual_machine
  ]
}