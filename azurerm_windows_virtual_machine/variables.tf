variable "rg_name" {
  description = "Nome do Resource Group onde os recursos serão criados."
  type        = string
}

variable "location" {
  description = "Região do Azure onde os recursos serão implantados."
  type        = string
}

variable "vm_size" {
  description = "Tamanho da máquina virtual a ser criada. Exemplo: 'Standard_B4ms'."
  type        = string
  default     = "Standard_B2ms"
}

variable "vm_name" {
  description = "Nome da máquina virtual a ser criada."
  type        = string
}

variable "admin_user_name" {
  description = "Nome de usuário do administrador da máquina virtual."
  type        = string
  default     = "adm_user"
}

variable "subnet_id" {
  description = "ID completo da Subnet onde a máquina virtual será criada. Exemplo: '/subscriptions/<subscription_id>/resourceGroups/<rg_name>/providers/Microsoft.Network/virtualNetworks/<vnet_name>/subnets/<subnet_name>'."
  type        = string
}

variable "kv_name" {
  description = "Nome do Key Vault existente que armazena segredos para a máquina virtual."
  type        = string
}

variable "rg_kv_name" {
  description = "Nome do Resource Group onde o Key Vault está localizado."
  type        = string
}

variable "tags" {
  description = "Mapa de tags para aplicar aos recursos criados no Azure."
  type        = map(string)
  default     = {
    created = "byterraform"
  }
}

variable "os_disk" {
  description = "Tipo de armazenamento para o disco do sistema operacional. Valores permitidos: 'StandardSSD_LRS', 'Standard_LRS', 'Premium_LRS'."
  type        = string
  default     = "StandardSSD_LRS"
}
