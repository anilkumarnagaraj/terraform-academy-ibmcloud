#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

module "rg_setup" {
  source  = "./resource-group"
  rg_name = var.rg_name
}

module "iam_policy" {
  source            = "./iam-access-policy"
  resource_group_id = module.rg_setup.resource_group_id
  accgrp_name       = var.accgrp_name
  invite_user_list  = var.invite_user_list
}