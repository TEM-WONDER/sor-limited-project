variable "public_key_loc" {
  default     = "/Users/teml/Documents/azure_terraform_projects/sor-limited-project/azure_vm_key.pub"
  description = "The location of the public key file for azure virtual machine"
}

variable "resource_group_location" {
  default     = "uksouth"
  description = "The location of the resource group"
  type        = string
}

variable "resource_group_name_prefix" {
  default     = "sor"
  description = "The prefix for the resource group name that is combined with a random string"
  type        = string
}
