#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

# IBM Cloud autheticate variables

variable "ibmcloud_api_key" {
  description = "IBM Cloud API key"
  type        = string
}

variable "training_rg_name" {
  type        = string
  description = "Name of the Resource Group used for Training"
  default     = "tf-academy-training-RG"
}

# Course Prefix for Resource name
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
    {
      name   = "user-3"
      email  = "user3@domain.com"
      apikey = "apikey-3"
    },
    {
      name   = "user-4"
      email  = "user4@domain.com"
      apikey = "apikey-4"
    },
    {
      name   = "user-5"
      email  = "user5@domain.com"
      apikey = "apikey-5"
    },
    {
      name   = "user-6"
      email  = "user6@domain.com"
      apikey = "apikey-6"
    },
    {
      name   = "user-7"
      email  = "user7@domain.com"
      apikey = "apikey-7"
    },
    {
      name   = "user-8"
      email  = "user8@domain.com"
      apikey = "apikey-8"
    },
    {
      name   = "user-9"
      email  = "user9@domain.com"
      apikey = "apikey-9"
    },
    {
      name   = "user-10"
      email  = "user10@domain.com"
      apikey = "apikey-10"
    },
    {
      name   = "user-11"
      email  = "user11@domain.com"
      apikey = "apikey-11"
    },
    {
      name   = "user-12"
      email  = "user12@domain.com"
      apikey = "apikey-12"
    },
        {
      name   = "user-13"
      email  = "user13@domain.com"
      apikey = "apikey-13"
    },
      {
      name   = "user-14"
      email  = "user14@domain.com"
      apikey = "apikey-14"
    },
    {
      name   = "user-15"
      email  = "user15@domain.com"
      apikey = "apikey-15"
    },
        {
      name   = "user-16"
      email  = "user10@domain.com"
      apikey = "apikey-10"
    },
            {
      name   = "user-17"
      email  = "user10@domain.com"
      apikey = "apikey-10"
    },
        {
      name   = "user-18"
      email  = "user10@domain.com"
      apikey = "apikey-10"
    },
            {
      name   = "user-19"
      email  = "user10@domain.com"
      apikey = "apikey-10"
    },
        {
      name   = "user-20"
      email  = "user10@domain.com"
      apikey = "apikey-10"
    },
            {
      name   = "user-21"
      email  = "user21@domain.com"
      apikey = "apikey-10"
    },
        {
      name   = "user-22"
      email  = "user22@domain.com"
      apikey = "apikey-10"
    },
            {
      name   = "user-23"
      email  = "user23@domain.com"
      apikey = "apikey-10"
    },
        {
      name   = "user-24"
      email  = "user24@domain.com"
      apikey = "apikey-10"
    },
            {
      name   = "user-25"
      email  = "user10@domain.com"
      apikey = "apikey-10"
    },
    {
      name   = "user-26"
      email  = "user26@domain.com"
      apikey = "apikey-10"
    },
    {
      name   = "user-27"
      email  = "user27@domain.com"
      apikey = "apikey-10"
    },
        {
      name   = "user-28"
      email  = "user27@domain.com"
      apikey = "apikey-10"
    },
            {
      name   = "user-28"
      email  = "user27@domain.com"
      apikey = "apikey-10"
    },
    {
      name   = "user-29"
      email  = "user27@domain.com"
      apikey = "apikey-10"
    },
    {
      name   = "user-30"
      email  = "user27@domain.com"
      apikey = "apikey-10"
    },
  ]
}

variable "decomission_timer" {
  description = "Time length to de-provision the resource after the creation."
  type        = string
  default     = "5m"
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
  default     = false
}

# Virtual Server for VPC

variable "create_vsi" {
  description = "If set to true, it will create VSI"
  type        = bool
  default     = false
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
