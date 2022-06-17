#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

variable "ibmcloud_api_key" {
  description = "IBM Cloud API key"
  type        = string
}

variable "schematics_workspace_resource_group" {
  description = "The ID of the resource group where you want to provision the workspace."
  type        = string
  default     = "default"
}

variable "decomission_timer" {
  description = "Time length to de-provision the resource after the creation."
  type        = string
  default     = "4m"
}