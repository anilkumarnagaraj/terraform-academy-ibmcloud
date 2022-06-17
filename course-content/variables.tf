#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################


# Resource Group 
variable "course_rg_name" {
  description = "Name of the Resource Group used for Training"
  type        = string
  default     = "tf-academy-training-RG"
}

variable "accgrp_name" {
  type        = string
  description = "Name of the Access Group used for Training"
  default     = "tf-academy-training-AG"
}

variable "invite_user_list" {
  type        = list(string)
  description = "Name of the Access Group used for Training in comma (,) seperated values"
  default     = ["user@testdomain.com"]
}

# Common
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

# Machine Learning - https://cloud.ibm.com/catalog/services/machine-learning
variable "ml_name" {
  description = "Machine Learning service instance name"
  type        = string
  default     = "VIT-machine-learning-service"
}

variable "ml_plan" {
  description = "Watson Studio service instance Plan"
  type        = string
  default     = "lite" # Other supported plans 'v2-standard/v2-professional'.
}

# Blockchain Platform - https://cloud.ibm.com/catalog/services/blockchain-platform
variable "bch_name" {
  description = "Blockchain Platform service instance name"
  type        = string
  default     = "VIT-blockchain-service"
}

variable "bch_plan" {
  description = "Blockchain Platform service Plan"
  type        = string
  default     = "standard"
}

# IOT Platform - https://cloud.ibm.com/catalog/services/internet-of-things-platform
variable "iot_name" {
  description = "Blockchain Platform service instance name"
  type        = string
  default     = "VIT-iot-service"
}

variable "iot_plan" {
  description = "IOT Platform service Plan"
  type        = string
  default     = "iotf-service-free"
}
