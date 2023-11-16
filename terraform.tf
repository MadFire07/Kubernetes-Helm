# Resource Group
resource "azurerm_resource_group" "group" {
  name     = "devops-aks-rg"
  location = "West Europe"
}

# Virtual Network
resource "azurerm_virtual_network" "network" {
  name                = "my-virtual-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
}

# Subnet
resource "azurerm_subnet" "example" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.group.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Azure Kubernetes Service
resource "azurerm_kubernetes_cluster" "example" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  dns_prefix          = "myakscluster" # Replace with your preferred DNS prefix

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "Standard_D2_v2" # Replace with the desired VM size
  }

  identity {
    type = "SystemAssigned"
  }
}

