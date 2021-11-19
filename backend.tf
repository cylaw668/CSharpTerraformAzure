terraform {
  backend "azurerm" {
    resource_group_name   = "tf_rg_blobStore"
    storage_account_name  = "clawdataterraform"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}