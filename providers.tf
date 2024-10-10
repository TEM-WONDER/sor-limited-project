# Description: This file is used to define the required providers for the Terraform configuration.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

# Configure the Azure provider
provider "azurerm" {
  features {}
}
