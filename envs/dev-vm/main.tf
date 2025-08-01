provider "azurerm" {
  features {}
}

module "vm" {
  source              = "../../modules/virtual-machine"
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  environment         = var.environment
  team                = var.team
}

