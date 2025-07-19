resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = "${var.aks_prefix}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "standard_d2_v3"
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }
}

#Permisos ACR Pull para el cluster de kubernets AKS
resource "azurerm_role_assignment" "aks_role_assignment" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}