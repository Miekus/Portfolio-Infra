data "azurerm_resource_group" "Portfolio-RG" { //not quite shure it should be there, need to ask 
  name = "Portfolio-RG"
}

module "Kubernates" {
  source                = "./modules/kubernates"
  resource_group_name   = data.azurerm_resource_group.Portfolio-RG.name
  cluster-location      = data.azurerm_resource_group.Portfolio-RG.location
  node-pool-size        = var.node-pool-size
  dns-prefix            = var.dns-prefix
  node-pool-name        = var.node-pool-name
  cluster-name          = var.kubernates-cluster-name
  note-pool-vm-size     = var.note-pool-vm-size
}

module "Helm" {
  source                = "./modules/helm-charts"
}