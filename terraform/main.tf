# Define el proveedor de Terraform y la versión requerida para Azure
# En mi caso debí usar esta versión para evitar problemas de compatibilidad, ya que me daba errores
# Tal como comenté en el foro.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.117.1"
    }
  }

  required_version = ">=1.1.0"
}

provider "azurerm" {
  features {}
}