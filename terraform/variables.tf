variable "subscription_id" {
  description = "Azure subscription ID used for the practical."
  type        = string
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "australiaeast"
}

variable "resource_group_name" {
  description = "Resource group containing the Week 08 infrastructure."
  type        = string
  default     = "koalatech-week08-rg"
}

variable "aks_cluster_name" {
  description = "AKS cluster name."
  type        = string
  default     = "koalatech-week08-aks"
}

variable "aks_node_vm_size" {
  description = "VM size for the three-node AKS system pool. Change this if the subscription has no quota for the default family."
  type        = string
  default     = "Standard_D2s_v3"
}
