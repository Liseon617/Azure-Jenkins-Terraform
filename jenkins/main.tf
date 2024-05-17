variable "resource_group_name" {}
variable "resource_group_location" {}
variable "public_ip_name" {}
variable "public_ip_allocation" {}
variable "network_interface" {}
variable "linux_virtual_machine" {}
variable "ip_configuration" {}
variable "private_ip_allocation" {}
variable "virtual_network_subnet_id" {}
variable "vm_size" {}
variable "admin_username" {}
variable "os_disk_caching" {}
variable "storage_account_type" {}
variable "source_image_publisher" {}
variable "source_image_offer" {}
variable "source_image_sku" {}
variable "source_image_version" {}
variable "host_os" {}
variable "current_env" {}

resource "azurerm_public_ip" "test-public-ip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = var.public_ip_allocation

  tags = {
    environment = var.current_env
  }
}

resource "azurerm_network_interface" "test-nic" {
  name                = var.network_interface
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_configuration
    subnet_id                     = var.virtual_network_subnet_id
    private_ip_address_allocation = var.private_ip_allocation
    public_ip_address_id          = azurerm_public_ip.test-public-ip.id
  }

  tags = {
    environment = var.current_env
  }
}

resource "azurerm_linux_virtual_machine" "test-vm" {
  name                = var.linux_virtual_machine
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.test-nic.id,
  ]

  custom_data  = filebase64("${path.module}/customdata.tpl")

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/azurerm.pub") # check for what is ssh key created in azure VM
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }

  provisioner "local-exec" {
    command = templatefile("${path.module}/${var.host_os}-ssh-script.tpl", {
      hostname = azurerm_linux_virtual_machine.test-vm.public_ip_address
      user = var.admin_username,
      identityfile = "~/.ssh/azurerm"
    })
    interpreter = var.host_os == "windows" ? ["Powershell", "-Command"] : [ "bash", "-c" ]
  }

  tags = {
    environment = var.current_env
  }
}

# data "azurerm_public_ip" "test-ip-data" {
#   name = azurerm_public_ip.test-public-ip.name
#   resource_group_name = var.resource_group_name
# }

output "public_ip_address" {
  value = "${azurerm_linux_virtual_machine.test-vm.name} : ${azurerm_linux_virtual_machine.test-vm.public_ip_address}"
  depends_on = [azurerm_linux_virtual_machine.test-vm]
}