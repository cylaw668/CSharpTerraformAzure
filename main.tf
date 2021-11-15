terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}  
}

resource "azurerm_resource_group" "tf_Demo" {
  name     = "tf_main_rg"
  location = "East US"
  tags = {
    environment = "dev"
    source      = "Terraform"
  }
}

resource "azurerm_container_group" "tf_container_Demo" {
  name                   = "weatherapi"
  location               = azurerm_resource_group.tf_Demo.location
  resource_group_name    = azurerm_resource_group.tf_Demo.name

  ip_address_type = "public"
  dns_name_label  = "dockerclawWeatherapi"
  os_type         = "Linux"

  container {
    name   = "weatherapi"
    image  = "dockerclaw/weatherapi:dev"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}