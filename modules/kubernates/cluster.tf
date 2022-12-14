resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster-name
  location            = var.cluster-location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns-prefix

  network_profile {
    network_plugin     = "azure"
    load_balancer_sku  = "standard"
    dns_service_ip     = "20.0.7.111"
    docker_bridge_cidr = "20.0.7.0/20"
    service_cidr       = "20.0.7.0/24"
  }


  default_node_pool {
    name              = var.node-pool-name
    node_count        = var.node-pool-size
    vm_size           = var.note-pool-vm-size
    vnet_subnet_id    = var.vnet-subnet-id
  }

  identity {
    type              = "SystemAssigned"
  }

  tags = {
    Environment       = "Production"
    Creator           = "Mateusz Kiszka"
  }
}

# resource "null_resource" "Kubectl" {
#   provisioner "local-exec" {
#     command = "az aks get-credentials --name ${var.cluster-name} --overwrite-existing --resource-group ${var.resource_group_name}"
#   }
#   depends_on = [
#     azurerm_kubernetes_cluster.aks
#   ]
# }

data "azurerm_container_registry" "container-registry" {
  name                = "MateuszKiszkaFlaskApp"
  resource_group_name = "Mateusz-Kiszka-RG"
}

resource "azurerm_role_assignment" "role-assignment" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.container-registry.id
  skip_service_principal_aad_check = true
}

# data "azurerm_key_vault" "key-vault" {
#   name                = "MK-KeyVault"
#   resource_group_name = "Mateusz-Kiszka-RG"
# }

# data "azuread_client_config" "current" {}


# resource "azurerm_key_vault_access_policy" "key-vault-access-policy" {
#   depends_on = [
#     null_resource.Kubectl
#   ]
#   key_vault_id = data.azurerm_key_vault.key-vault.id
#   tenant_id    = data.azuread_client_config.current.tenant_id
#   object_id    = data.azuread_client_config.current.object_id

#   secret_permissions = ["Delete", "Get", "List", "Set"]
#   storage_permissions  = ["Delete", "Get", "List", "Set"]
# }

# resource "azurerm_role_assignment" "role-assignmen-kv" {
#   principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
#   role_definition_name             = "Key Vault Secrets Officer"
#   scope                            = data.azurerm_key_vault.key-vault.id
#   skip_service_principal_aad_check = true
# }
