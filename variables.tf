# Description: This file contains the variables that are used in the main.tf file
# create a variable for the public key location
variable "public_key_loc" {
  default     = "/Users/yourusername/Documents/azure_terraform_projects/sor-limited-project/azure_vm_key.pub"
  description = "The location of the public key file for azure virtual machine"
}
# craete a variable for the resource group location
variable "resource_group_location" {
  default     = "uksouth"
  description = "The location of the resource group"
  type        = string
}
# create a variable for the resource group name prefix
variable "resource_group_name_prefix" {
  default     = "sor"
  description = "The prefix for the resource group name that is combined with a random string"
  type        = string
}
