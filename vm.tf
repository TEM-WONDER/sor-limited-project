resource "azurerm_availability_set" "avset" {
  name                         = "sor-avset"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  managed                      = true
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
}

resource "azurerm_virtual_machine" "vm1" {
  name                          = "${random_pet.prefix.id}-vm1"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  network_interface_ids         = [azurerm_network_interface.nic1.id]
  vm_size                       = "Standard_B1s"
  delete_os_disk_on_termination = true

  storage_os_disk {
    name              = "${random_pet.prefix.id}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${random_pet.prefix.id}-vm1"
    admin_username = "azureuser"

  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = file("${var.public_key_loc}")
    }
  }
}

resource "azurerm_virtual_machine" "vm2" {
  name                          = "${random_pet.prefix.id}-vm2"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  network_interface_ids         = [azurerm_network_interface.nic2.id]
  vm_size                       = "Standard_B1s"
  delete_os_disk_on_termination = true

  storage_os_disk {
    name              = "${random_pet.prefix.id}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${random_pet.prefix.id}-vm2"
    admin_username = "azureuser"

  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = file("${var.public_key_loc}")
    }
  }
}