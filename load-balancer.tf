# Define LB
resource "azurerm_lb" "lb" {
  name                = "${random_pet.prefix.id}-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "${random_pet.prefix.id}-fe"
    subnet_id            = azurerm_subnet.my_terraform_subnet_2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "bap" {
  name                = "${random_pet.prefix.id}-bap"
  #resource_group_name = azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.lb.id
}

resource "azurerm_lb_probe" "probe" {
  name                = "${random_pet.prefix.id}-probe"
  #resource_group_name = azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.lb.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "rule" {
  name                     = "${random_pet.prefix.id}-rule"
  #resource_group_name      = azurerm_resource_group.rg.name
  loadbalancer_id          = azurerm_lb.lb.id
  #frontend_ip_configuration_id = azurerm_lb.lb.frontend_ip_configuration[0].id
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[0].name
  #backend_address_pool_id = azurerm_lb_backend_address_pool.bap.id
  probe_id                = azurerm_lb_probe.probe.id
  protocol                = "Tcp"
  frontend_port           = 80
  backend_port            = 80
}

resource "azurerm_network_interface_backend_address_pool_association" "association-vm1" {
  network_interface_id    = azurerm_network_interface.nic1.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bap.id
}

resource "azurerm_network_interface_backend_address_pool_association" "association-vm2" {
  network_interface_id    = azurerm_network_interface.nic2.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bap.id
}