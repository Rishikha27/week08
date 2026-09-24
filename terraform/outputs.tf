output "resource_group_name" {
  value = azurerm_resource_group.week08.name
}

output "acr_name" {
  value = azurerm_container_registry.week08.name
}

output "acr_login_server" {
  value = azurerm_container_registry.week08.login_server
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.week08.name
}

output "storage_account_name" {
  value = azurerm_storage_account.week08.name
}

output "storage_connection_string" {
  value     = azurerm_storage_account.week08.primary_connection_string
  sensitive = true
}
