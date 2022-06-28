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
  default = "default"
}

variable "invite_user_list" {
  type        = list(string)
  description = "Name of the Access Group used for Training in comma (,) seperated values"
  default     = ["test@testdomain.com", "test1@testdomain.com"]
}

variable "decomission_timer" {
  description = "Time length to de-provision the resource after the creation."
  type        = string
  default     = "4m"
}

variable "create_bc" {
  description = "If set to true, it will create block chain"
  type        = bool
  default     = true
}

variable "create_iot" {
  description = "If set to true, it will create iot"
  type        = bool
  default     = true
}

variable "create_ml" {
  description = "If set to true, it will create machine learning"
  type        = bool
  default     = true
}

variable "create_ws" {
  description = "If set to true, it will create watson"
  type        = bool
  default     = true
}