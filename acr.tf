
#Create ACR user assignet identity
resource "azurerm_user_assigned_identity" "acr_identity" {
  resource_group_name = azurerm_resource_group.cp2.name
  location            = azurerm_resource_group.cp2.location
  name                = "${var.acr_name}Identity"

  depends_on = [
    azurerm_resource_group.cp2
  ]

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "random_string" "random" {
  length  = 10
  special = false
}

resource "azurerm_container_registry" "acr_container_registry" {
  resource_group_name   = azurerm_resource_group.cp2.name
  location              = azurerm_resource_group.cp2.location
  name                  = "${var.acr_name}${random_string.random.result}"
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
    environment = "CP2"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  depends_on = [azurerm_resource_group.cp2, random_string.random]


}
