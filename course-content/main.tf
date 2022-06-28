#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

module "course-setup" {
  source = "github.com/anilkumarnagaraj/terraform-academy-ibmcloud//course-setup?ref=fix_governance"

  rg_name          = var.course_rg_name
  accgrp_name      = var.accgrp_name
  invite_user_list = var.invite_user_list
}

# Machine Learning - https://cloud.ibm.com/catalog/services/machine-learning

module "ml" {
  source = "./machine-learning"

  count        = var.create_ml ? 1 : 0
  course_rg_id = module.course-setup.resource_group_id
  location     = var.location
  ml_name      = var.ml_name
  ml_plan      = var.ml_plan
}


# Blockchain Platform - https://cloud.ibm.com/catalog/services/blockchain-platform
module "blockchain" {
  source = "./blockchain-platform"

  count        = var.create_bc ? length(module.course-setup.resource_group_id) : 0
  course_rg_id = module.course-setup.resource_group_id
  location     = var.location
  bch_name     = var.bch_name
  bch_plan     = var.bch_plan
}


# IOT Platform - https://cloud.ibm.com/catalog/services/internet-of-things-platform
module "iot" {
  source = "./iot-platform"

  count        = var.create_iot ? 1 : 0
  course_rg_id = module.course-setup.resource_group_id
  location     = var.location
  iot_name     = var.iot_name
  iot_plan     = var.iot_plan
}
*/


/*
# Watson Studio - https://cloud.ibm.com/catalog/services/watson-studio
module "watson-studio" {
  source = "./watson-studio"

  count        = var.create_ws ? 1 : 0
  course_rg_id = module.course-setup.resource_group_id
  location     = var.location
  ws_name      = var.ws_name
  ws_plan      = var.ws_plan
}
*/