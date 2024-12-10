output "vm_id" {
  description = "ID da máquina virtual criada"
  value       = azurerm_windows_virtual_machine.example.id
}

output "vm_name" {
  description = "Nome da máquina virtual criada"
  value       = azurerm_windows_virtual_machine.example.name
}

output "nic_id" {
  description = "ID da interface de rede criada"
  value       = azurerm_network_interface.nic-vm.id
}
