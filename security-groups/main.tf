variable "security_group" {}
variable "resource_group_name" {}
variable "resource_group_location" {}
variable "security_rule" {}
variable "security_rule_priority" {}
variable "security_rule_direction" {}
variable "security_rule_access" {}
variable "security_rule_protocol" {}
variable "source_port_range" {}
variable "destination_port_range" {}
variable "source_address_prefix" {}
variable "destination_address_prefix" {}
variable "virtual_network_subnet_id" {}
variable "current_env" {}

# Create a security group
resource "azurerm_network_security_group" "test-sg" {
  name                = var.security_group
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name


  # security_rule {
  #   name                       = "SSH"
  #   priority                   = 99
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "22"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }
  # security_rule {
  #   name                       = "HTTPS"
  #   priority                   = 98
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "443"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }
  # security_rule {
  #   name                       = "HTTP"
  #   priority                   = 97
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "80"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }

  tags = {
    environment = var.current_env
  }
}

resource "azurerm_network_security_rule" "test-dev-rule" {
  name                        = var.security_rule #"test123"
  priority                    = var.security_rule_priority
  direction                   = var.security_rule_direction
  access                      = var.security_rule_access
  protocol                    = var.security_rule_protocol
  source_port_range           = var.source_port_range
  destination_port_range      = var.destination_port_range
  source_address_prefix       = var.source_address_prefix
  destination_address_prefix  = var.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.test-sg.name
}

resource "azurerm_subnet_network_security_group_association" "test-rule-association" {
  subnet_id                 = var.virtual_network_subnet_id
  network_security_group_id = azurerm_network_security_group.test-sg.id
}
