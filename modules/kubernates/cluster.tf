resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster-name
  location            = var.cluster-location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns-prefix

  default_node_pool {
    name       = var.node-pool-name
    node_count = var.node-pool-size
    vm_size    = var.note-pool-vm-size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
    Creator = "Mateusz Kiszka"
  }
}