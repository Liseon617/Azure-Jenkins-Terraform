variable "resource_group" {
  type        = string
  description = "Azure Resource Group Name"
}

variable "location" {
  type = string
  description = "Resource Group Location"
}

variable "environment" {
  type        = string
  description = "Azure Environment"
}

variable "virtual_network" {
  type        = string
  description = "Virtual Network name"
}

variable "virtual_network_subnet" {
  type        = string
  description = "Virtual Network subnet name"
}

variable "address_space" {
  type        = list(string)
  description = "CIDR Block for VM"
}

variable "address_prefixes" {
  type        = list(string)
  description = "Available Public Subnet CIDR values"
}

variable "security_group" {
    type        = string
  description = "Virtual Network Security Group "
}

variable "security_rule" {
  type        = string
  description = "Virtual Network Security Rule"
}

variable "security_rule_priority" {
  type = number
  description = "Rule Priority"
}

variable "security_rule_direction" {
  type = string
  description = "Rule Direction"
}

variable "security_rule_access" {
  type = string
  description = "Rule Access"
}

variable "security_rule_protocol" {
  type = string
  description = "Security Rule Protocol"
}

variable "source_port_range" {
  type = string
  description = "Source Range"
}

variable "destination_port_range" {
  type = string
  description = "Destination Range"
}

variable "source_address_prefix" {
  type = string
  description = "Source Address Prefix"
}

variable "destination_address_prefix" {
  type = string
  description = "Destination Address Prefix"
}

variable "public_ip" {
  type        = string
  description = "Name of the public IP"
}

variable "public_ip_allocation" {
  type        = string
  description = "Allocation method for the public IP"
}

variable "network_interface" {
  type        = string
  description = "Name of the network interface"
}

variable "linux_virtual_machine" {
  type        = string
  description = "Name of the Linux virtual machine"
}

variable "ip_configuration" {
  type        = string
  description = "Name of the IP configuration"
}

variable "private_ip_allocation" {
  type        = string
  description = "Allocation method for the private IP"
}

variable "vm_size" {
  type        = string
  description = "Size of the virtual machine"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the virtual machine"
}

variable "os_disk_caching" {
  type        = string
  description = "Caching type for the OS disk"
}

variable "storage_account_type" {
  type        = string
  description = "Type of storage account for the OS disk"
}

variable "source_image_publisher" {
  type        = string
  description = "Publisher of the source image"
}

variable "source_image_offer" {
  type        = string
  description = "Offer of the source image"
}

variable "source_image_sku" {
  type        = string
  description = "SKU of the source image"
}

variable "source_image_version" {
  type        = string
  description = "Version of the source image"
}

variable "host_os" {
  type        = string
  description = "Operating system of the virtual machine"
  default = "windows"
}