provider "azurerm" {
  features {}
}

# Pool numerico para criação de recursos unicos
resource "random_integer" "random_id" {
  min = 1000
  max = 9999
}

# Consumindo Resource Group existente
data "azurerm_resource_group" "resource_group_vm" {
  name = var.rg_name
}

# Criando nic para VM
resource "azurerm_network_interface" "nic-vm" {
  name                = format("nic-%s-%d", var.vm_name, random_integer.random_id.result) # Gera algo como "nic-vm_name-1234"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resource_group_vm.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

# Consumindo Key Vault existente
data "azurerm_key_vault" "kv-resource" {
  name                = var.kv_name
  resource_group_name = var.rg_kv_name
}

# Consumindo Secret do Key Vault existente
data "azurerm_key_vault_secret" "kv-secret" {
  name         = "password-admin-win"
  key_vault_id = data.azurerm_key_vault.kv-resource.id
}

# Criando VM Windows
resource "azurerm_windows_virtual_machine" "example" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_user_name
  admin_password      = data.azurerm_key_vault_secret.kv-secret.value
  tags = var.tags
  network_interface_ids = [
    azurerm_network_interface.nic-vm.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}