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

resource "azurerm_dev_test_virtual_network" "network" {
  name                = "t-clo-902-bdx-2"
  lab_name            = azurerm_dev_test_lab.lab.name
  resource_group_name = azurerm_resource_group.resource-group.name

  subnet {
    use_public_ip_address           = "Allow"
    use_in_virtual_machine_creation = "Allow"
  }

  tags = {
    "city"               = "bdx"
    "cost:application"   = "socle-student"
    "cost:business-unit" = "epitech"
    "cost:environment"   = "prod"
    "group_number"       = "2"
    "module"             = "t-clo-902"
  }
}

resource "azurerm_dev_test_linux_virtual_machine" "vm1" {
  name                   = "k8s-pod1"
  lab_name               = azurerm_dev_test_lab.lab.name
  resource_group_name    = azurerm_resource_group.resource-group.name
  location               = azurerm_resource_group.resource-group.location
  size                   = "Standard_A4_v2"
  username               = "epitechusr"
  ssh_key                = file("~/.ssh/id_rsa.pub")
  lab_virtual_network_id = azurerm_dev_test_virtual_network.network.id
  lab_subnet_name        = azurerm_dev_test_virtual_network.network.subnet[0].name
  storage_type           = "Standard"
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
  name                   = "k8s-pod2"
  lab_name               = azurerm_dev_test_lab.lab.name
  resource_group_name    = azurerm_resource_group.resource-group.name
  location               = azurerm_resource_group.resource-group.location
  size                   = "Standard_A4_v2"
  username               = "epitechusr"
  ssh_key                = file("~/.ssh/id_rsa.pub")
  lab_virtual_network_id = azurerm_dev_test_virtual_network.network.id
  lab_subnet_name        = azurerm_dev_test_virtual_network.network.subnet[0].name
  storage_type           = "Standard"
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
resource "azurerm_dev_test_linux_virtual_machine" "vm3" {
  name                   = "k8s-pod3"
  lab_name               = azurerm_dev_test_lab.lab.name
  resource_group_name    = azurerm_resource_group.resource-group.name
  location               = azurerm_resource_group.resource-group.location
  size                   = "Standard_A4_v2"
  username               = "epitechusr"
  ssh_key                = file("~/.ssh/id_rsa.pub")
  lab_virtual_network_id = azurerm_dev_test_virtual_network.network.id
  lab_subnet_name        = azurerm_dev_test_virtual_network.network.subnet[0].name
  storage_type           = "Standard"
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
  lab_virtual_network_id = azurerm_dev_test_virtual_network.network.id
  lab_subnet_name        = azurerm_dev_test_virtual_network.network.subnet[0].name
  storage_type           = "Standard"
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
