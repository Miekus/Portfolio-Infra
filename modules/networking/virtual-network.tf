
resource "azurerm_virtual_network" "vNet" {
  name                = "MK-vNet-Kubernates"
  location            = var.cluster-location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/8"]

  tags = {
    Creator           = "Mateusz Kiszka"
    Environment       = "Production"
  }
}

resource "azurerm_subnet" "MK-SubNet" {
  name                 = "MK-SubNet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vNet.name
  address_prefixes     = ["10.0.0.0/16"]

}

resource "azurerm_network_profile" "MK-Network-Profile" {
  name                 = "MK-Network-Profile"
  location             = var.cluster-location
  resource_group_name  = var.resource_group_name

  container_network_interface {
    name               = "MK-Container-Network-Interface"

    ip_configuration {
      name             = "MK-Ip-Config"
      subnet_id        = azurerm_subnet.MK-SubNet.id
    }
  }
    tags = {
    Creator            = "Mateusz Kiszka"
    Environment        = "Production"
  }
}