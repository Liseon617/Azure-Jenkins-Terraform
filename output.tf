# #jenkins
# output "public_ip_address" {
#   value = "${azurerm_linux_virtual_machine.test-vm.name} : ${data.azurerm_public_ip.test-ip-data.ip_address}"
#   depends_on = [azurerm_linux_virtual_machine.test-vm]
# }