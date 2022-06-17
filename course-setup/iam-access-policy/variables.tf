#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

variable "accgrp_name" {
  type        = string
  description = "Name of the Access Group used for Training"
  default     = "tf-academy-training-AG"
}

variable "invite_user_list" {
  type        = list(string)
  description = "Name of the Access Group used for Training in comma (,) seperated values"
  default     = ["mkm_rahman@yahoo.com"]
}

variable "resource_group_id" {
  type        = string
  description = "Resource Group ID"
}
