#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

module "iam_policy" {
  source            = "./iam-access-policy"
  resource_group_id = var.course_resource_group_id
  accgrp_name       = var.accgrp_name
  invite_user_list  = var.invite_user_list
}