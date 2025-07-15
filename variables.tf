variable "resource_group_name" {
  default     = "rg-devops-cp2"
  description = "Usado para definir el nombre del grupo de recursos"
}
variable "location_name" {
  default     = "West Europe"
  description = "Usado para indicar la localizacion de Azure"
}

variable "nic_name" {
  default     = "nic-cp2"
  description = "Network interface de Azure"
}

variable "network_name" {
  default     = "network-cp2"
  description = "Network de azure CP2"
}

variable "subnet_name" {
  default     = "subnet-cp2"
  description = "Subnet de azure CP2"
}

variable "acr_name" {
  default     = "jrurudevops"
  description = "Nombre del registro ACR"
}

variable "aks_name" {
  default     = "aks_cp2"
  description = "Nombre AKS"
}
variable "aks_prefix" {
  default     = "cp2"
  description = "Nombre AKS"
}
