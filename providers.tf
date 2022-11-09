terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    azuread = {
      version = ">= 2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.5.1"
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
provider "helm" {
  kubernetes {
    host                   = module.Kubernates.cluser-host
    client_certificate     = base64decode(module.Kubernates.cluster-client-certificate)
    client_key             = base64decode(module.Kubernates.cluser-client-key)
    cluster_ca_certificate = base64decode(module.Kubernates.cluster-certificate-authority)

  }
}
