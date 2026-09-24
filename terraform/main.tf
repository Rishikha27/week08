resource "random_string" "global_suffix" {
  length  = 6
  upper   = false
  special = false
}

locals {
  acr_name             = "riyaweek08acr${random_string.global_suffix.result}"
  storage_account_name = "riyaweek08st${random_string.global_suffix.result}"
}

resource "azurerm_resource_group" "week08" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_registry" "week08" {
  name                = local.acr_name
  resource_group_name = azurerm_resource_group.week08.name
  location            = azurerm_resource_group.week08.location
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azurerm_storage_account" "week08" {
  name                            = local.storage_account_name
  resource_group_name             = azurerm_resource_group.week08.name
  location                        = azurerm_resource_group.week08.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "student_profile_photo" {
  name                  = "student-profile-photo"
  storage_account_id    = azurerm_storage_account.week08.id
  container_access_type = "private"
}

resource "azurerm_kubernetes_cluster" "week08" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.week08.location
  resource_group_name = azurerm_resource_group.week08.name
  dns_prefix          = "koalatech-week08"
  sku_tier            = "Free"

  default_node_pool {
    name                        = "system"
    node_count                  = 3
    vm_size                     = var.aks_node_vm_size
    os_disk_size_gb             = 64
    type                        = "VirtualMachineScaleSets"
    temporary_name_for_rotation = "tempnode"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  role_based_access_control_enabled = true
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.week08.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.week08.kubelet_identity[0].object_id
}
