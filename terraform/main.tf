provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource-group" {
  name     = "t-clo-902-bdx-2"
  location = "West Europe"
  tags = {
    "city"               = "bdx"
    "cost:application"   = "socle-student"
    "cost:business-unit" = "epitech"
    "cost:environment"   = "prod"
    "group_number"       = "2"
    "module"             = "t-clo-902"
  }
}

resource "azurerm_dev_test_lab" "lab" {
  name                = "t-clo-902-bdx-2"
  location            = azurerm_resource_group.resource-group.location
  resource_group_name = azurerm_resource_group.resource-group.name
  tags = {
    "group_number" = "2"
    "module"       = "t-clo-902"
  }
}

data "azurerm_dev_test_virtual_network" "network" {
  name                = "t-clo-902-bdx-2"
  lab_name            = azurerm_dev_test_lab.lab.name
  resource_group_name = azurerm_resource_group.resource-group.name
}

output "lab_subnet_name" {
  value = data.azurerm_dev_test_virtual_network.network.allowed_subnets[0].lab_subnet_name
}


resource "azurerm_dev_test_linux_virtual_machine" "vm1" {
  name                   = "k8s-node1"
  lab_name               = azurerm_dev_test_lab.lab.name
  resource_group_name    = azurerm_resource_group.resource-group.name
  location               = azurerm_resource_group.resource-group.location
  size                   = "Standard_A4_v2"
  username               = "epitechusr"
  ssh_key                = file("~/.ssh/id_rsa.pub")
  lab_virtual_network_id = data.azurerm_dev_test_virtual_network.network.id
  lab_subnet_name        = data.azurerm_dev_test_virtual_network.network.allowed_subnets[0].lab_subnet_name
  storage_type           = "Standard"
  allow_claim            = false
  notes                  = "no"

  gallery_image_reference {
    offer     = "UbuntuServer"
    publisher = "Canonical"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    "k8s-type" = "worker"
  }
}
resource "azurerm_dev_test_linux_virtual_machine" "vm2" {
  name                   = "k8s-node2"
  lab_name               = azurerm_dev_test_lab.lab.name
  resource_group_name    = azurerm_resource_group.resource-group.name
  location               = azurerm_resource_group.resource-group.location
  size                   = "Standard_A4_v2"
  username               = "epitechusr"
  ssh_key                = file("~/.ssh/id_rsa.pub")
  lab_virtual_network_id = data.azurerm_dev_test_virtual_network.network.id
  lab_subnet_name        = data.azurerm_dev_test_virtual_network.network.allowed_subnets[0].lab_subnet_name
  storage_type           = "Standard"
  allow_claim            = false
  notes                  = "no"

  gallery_image_reference {
    offer     = "UbuntuServer"
    publisher = "Canonical"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    "k8s-type" = "worker"
  }
}

resource "azurerm_dev_test_linux_virtual_machine" "vm4" {
  name                   = "k8s-control-plane"
  lab_name               = azurerm_dev_test_lab.lab.name
  resource_group_name    = azurerm_resource_group.resource-group.name
  location               = azurerm_resource_group.resource-group.location
  size                   = "Standard_A4_v2"
  username               = "epitechusr"
  ssh_key                = file("~/.ssh/id_rsa.pub")
  lab_virtual_network_id = data.azurerm_dev_test_virtual_network.network.id
  lab_subnet_name        = data.azurerm_dev_test_virtual_network.network.allowed_subnets[0].lab_subnet_name
  storage_type           = "Standard"
  allow_claim            = false
  notes                  = "no"

  gallery_image_reference {
    offer     = "UbuntuServer"
    publisher = "Canonical"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    "k8s-type" = "control-plane"
  }
}

# resource "azurerm_public_ip" "load-balancer-public-ip" {
#   name                = "LoadBalancerPublicIP"
#   location            = azurerm_resource_group.resource-group.location
#   resource_group_name = azurerm_resource_group.resource-group.name
#   allocation_method   = "Static"
# }

# resource "azurerm_lb" "load-balancer" {
#   name                = "LoadBalancer"
#   location            = azurerm_resource_group.resource-group.location
#   resource_group_name = azurerm_resource_group.resource-group.name

#   frontend_ip_configuration {
#     name                 = "PublicIPAddress"
#     public_ip_address_id = azurerm_public_ip.load-balancer-public-ip.id
#     subnet_id            = data.azurerm_dev_test_virtual_network.network.allowed_subnets[0].resource_id
#   }
# }
