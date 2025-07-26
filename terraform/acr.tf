#Crea una identidad asignada por el usuario para el Azure Container Registry (ACR)
#Esta identidad se utilizará para otorgar permisos al ACR
resource "azurerm_user_assigned_identity" "acr_identity" {
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  name                = "${var.acr_name}Identity"

  depends_on = [
    azurerm_resource_group.resource_group
  ]

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Genera una cadena aleatoria para usar en el nombre del ACR
resource "random_string" "random" {
  length  = 10
  special = false
}

#Crea el Azure Container Registry (ACR). 
#Utiliza la identidad asignada por el usuario creada anteriormente.
# Para crearlo, es necesario que exista el grupo de recursos, creado en el fichero resources.tf,
# y la cadena aleatoria definida anteriormente para evitar conflictos de nombres.
resource "azurerm_container_registry" "acr" {
  name                  = "${var.acr_name}${random_string.random.result}"
  resource_group_name   = azurerm_resource_group.resource_group.name
  location              = azurerm_resource_group.resource_group.location
  sku                   = "Basic"
  admin_enabled         = true
  data_endpoint_enabled = false

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.acr_identity.id
    ]
  }

  tags = {
    environment = "casopractico2"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  depends_on = [azurerm_resource_group.resource_group, random_string.random]


}
