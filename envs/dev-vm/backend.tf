terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-backend"
    storage_account_name = "tfbackendstore306"
    container_name       = "tfstate"
    key                  = "vm-dev.terraform.tfstate"
  }
}

