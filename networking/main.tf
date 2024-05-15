variable "resource_group_name" {}
variable "resource_group_location" {}
variable "virtual_network" {}
variable "virtual_network_subnet" {}
variable "address_space" {}
variable "address_prefixes" {}
variable "current_env" {}


# Create a resource group
resource "azurerm_resource_group" "test-rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags = {
    environment = var.current_env
  }
}


# Create a virtual network within the resource group
resource "azurerm_virtual_network" "test-vm" {
  name                = var.virtual_network
  resource_group_name = azurerm_resource_group.test-rg.name
  location            = azurerm_resource_group.test-rg.location
  address_space       = var.address_space # cidr block

  tags = {
    environment = var.current_env
  }
}

# create a public subnet on the virtual network
resource "azurerm_subnet" "test-subnet" {
  name                 = var.virtual_network_subnet
  resource_group_name  = azurerm_resource_group.test-rg.name
  virtual_network_name = azurerm_virtual_network.test-vm.name
  address_prefixes     = var.address_prefixes
}

output "resource_group_name" {
  value = azurerm_resource_group.test-rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.test-rg.location
}

output "virtual_network_subnet_id" {
  value = azurerm_subnet.test-subnet.id
}
