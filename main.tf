resource "azurerm_resource_group" "Mateusz-Kiszka-RG-Kubernates" {
  name     = "Mateusz-Kiszka-RG-Kubernates"
  location = "West Europe"
}

module "Kubernates" {
  source                = "./modules/kubernates"
  resource_group_name   = azurerm_resource_group.Mateusz-Kiszka-RG-Kubernates.name
  cluster-location      = azurerm_resource_group.Mateusz-Kiszka-RG-Kubernates.location
  node-pool-size        = var.node-pool-size
  dns-prefix            = var.dns-prefix
  node-pool-name        = var.node-pool-name
  cluster-name          = var.kubernates-cluster-name
  note-pool-vm-size     = var.note-pool-vm-size
}

module "Helm" {
  source                = "./modules/helm-charts"
}