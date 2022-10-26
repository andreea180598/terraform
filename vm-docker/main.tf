//create resource group 
resource "azurerm_resource_group" "test" {
  name     = "andreea-rg"
  location = "East US"

  tags = {
    environment = "dev"
  }
}

//create a virtual network
resource "azurerm_virtual_network" "test" {
  name                = "vnetwork"
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
  address_space       = ["10.123.0.0/16"]

  tags = {
    environment = "dev"
  }
}

//create subnet
resource "azurerm_subnet" "test" {
  name                 = "test-subnet"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.123.1.0/24"]

}

//create security group
resource "azurerm_network_security_group" "test" {
  name                = "test-sg"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  tags = {
    environment = "dev"
  }
}

//create nw security rule
resource "azurerm_network_security_rule" "test" {
  name                        = "dev-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test.name
  network_security_group_name = azurerm_network_security_group.test.name
}

resource "azurerm_subnet_network_security_group_association" "test" {
  subnet_id                 = azurerm_subnet.test.id
  network_security_group_id = azurerm_network_security_group.test.id
}

//create public ip with dynamic allocation
resource "azurerm_public_ip" "test" {
  name                = "public-ip"
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "dev"
  }
}

//create nw interface
resource "azurerm_network_interface" "test" {
  name                = "nic"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.test.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.test.id
  }

  tags = {
    environment = "dev"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                  = "linux-vm"
  resource_group_name   = azurerm_resource_group.test.name
  location              = azurerm_resource_group.test.location
  size                  = "Standard_D2s_v3"
  admin_username        = "andreea"
  network_interface_ids = [azurerm_network_interface.test.id]

  custom_data = filebase64("customdata.sh")

  admin_ssh_key {
    username   = "andreea"
    public_key = file("C:/Users/ZZ0311826/.ssh/terraform1_1_key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

data "azurerm_public_ip" "test" {
  name                = azurerm_public_ip.test.name
  resource_group_name = azurerm_resource_group.test.name
}

//save the public ip in output -> ip_address is the variable name from tfstate
// terraform output -> shows the public_ip_address output result
output "public_ip_address" {
    value = "${azurerm_linux_virtual_machine.test.name}: ${data.azurerm_public_ip.test.ip_address}"
}