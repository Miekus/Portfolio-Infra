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