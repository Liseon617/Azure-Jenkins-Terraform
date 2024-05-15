terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

module "networking" {
  source                  = "./networking"
  resource_group_name     = var.resource_group
  resource_group_location = var.location
  virtual_network         = var.virtual_network
  virtual_network_subnet  = var.virtual_network_subnet
  address_space           = var.address_space
  address_prefixes        = var.address_prefixes
  current_env             = var.environment
}

module "security_group" {
  source                     = "./security-groups"
  resource_group_name        = module.networking.resource_group_name #module
  resource_group_location    = module.networking.resource_group_location #module
  security_group             = var.security_group
  security_rule              = var.security_rule
  security_rule_priority     = var.security_rule_priority
  security_rule_direction    = var.security_rule_direction
  security_rule_access       = var.security_rule_access
  security_rule_protocol     = var.security_rule_protocol
  source_port_range          = var.source_port_range
  destination_port_range     = var.destination_port_range
  source_address_prefix      = var.source_address_prefix
  destination_address_prefix = var.destination_address_prefix
  virtual_network_subnet_id     = module.networking.virtual_network_subnet_id #module
  current_env                = var.environment
}

module "jenkins" {
  source                    = "./jenkins"
  resource_group_name        = module.networking.resource_group_name #module
  resource_group_location    = module.networking.resource_group_location #module
  public_ip_name            = var.public_ip
  public_ip_allocation      = var.public_ip_allocation
  network_interface         = var.network_interface
  linux_virtual_machine     = var.linux_virtual_machine
  ip_configuration          = var.ip_configuration
  private_ip_allocation     = var.private_ip_allocation
  virtual_network_subnet_id = module.networking.virtual_network_subnet_id #module
  vm_size                   = var.vm_size
  admin_username            = var.admin_username
  os_disk_caching           = var.os_disk_caching
  storage_account_type      = var.storage_account_type
  source_image_publisher    = var.source_image_publisher
  source_image_offer        = var.source_image_offer
  source_image_sku          = var.source_image_sku
  source_image_version      = var.source_image_version
  host_os                   = var.host_os
  current_env               = var.environment
}

output "public_ip_address" {
  value = module.jenkins.public_ip_address
}