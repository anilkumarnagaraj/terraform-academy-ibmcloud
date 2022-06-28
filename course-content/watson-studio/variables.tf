#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

variable "create_ws" {
  description = "If set to true, it will create watson"
  type        = bool
}

# Resource Group 
variable "course_rg_id" {
  description = "Resource Groupe ID"
  type        = string
}

variable "location" {
  description = "Provisioning Region/Location for the instance"
  type        = string
  default     = "us-south"
}

# Watson Studio - https://cloud.ibm.com/catalog/services/watson-studio
variable "ws_name" {
  description = "Watson Studio service instance name"
  type        = string
  default     = "VIT-watson-studio-service"
}

variable "ws_plan" {
  description = "Watson Studio service instance Plan"
  type        = string
  default     = "free-v1" # Other supported plan 'enterprise-v1'.
}
