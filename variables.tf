#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

# IBM Cloud autheticate variables

variable "ibmcloud_api_key" {
  description = "IBM Cloud API key"
  type        = string
}

variable "course_prefix" {
  description = "Prefix to the Names of all Cloud Resources"
  type        = string
  default     = "tf-acacdemy-training"
}

variable "invite_user_list" {
  type = list(object({
    name   = string
    email  = string
    apikey = string
  }))

  default = [
    {
      name   = "user-1"
      email  = "user1@domain.com"
      apikey = "apikey-1"
    },
    {
      name   = "user-2"
      email  = "user2@domain.com"
      apikey = "apikey-2"
    },
  ]
}

variable "decomission_timer" {
  description = "Time length to de-provision the resource after the creation."
  type        = string
  default     = "15m"
}

# Blockchain

variable "create_bc" {
  description = "If set to true, it will create block chain"
  type        = bool
  default     = false
}

# IOT

variable "create_iot" {
  description = "If set to true, it will create iot"
  type        = bool
  default     = false
}

# Machine Learning

variable "create_ml" {
  description = "If set to true, it will create machine learning"
  type        = bool
  default     = false
}

# Blockchain

variable "create_ws" {
  description = "If set to true, it will create watson"
  type        = bool
  default     = true
}

# Virtual Server for VPC

variable "create_vsi" {
  description = "If set to true, it will create VSI"
  type        = bool
  default     = true
}

variable "image" {
  description = "Image ID for the instance"
  type        = string
  default     = "ibm-redhat-7-9-minimal-amd64-3"
}

variable "profile" {
  description = "Profile type for the Instance"
  type        = string
  default     = "gx2-16x128x1v100"
}
