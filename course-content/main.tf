#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

module "course-setup" {
  source = "github.com/Cloud-Schematics/terraform-academy-ibmcloud//course-setup"

  rg_name     = var.course_rg_name
  accgrp_name = var.accgrp_name
  invite_user_list   = var.invite_user_list
}

# Blockchain Platform - https://cloud.ibm.com/catalog/services/blockchain-platform
module "blockchain" {
  source = "./blockchain-platform"

  course_rg_id = module.course-setup.resource_group_id
  location     = var.location
  bch_name     = var.bch_name
  bch_plan     = var.bch_plan
}


# IOT Platform - https://cloud.ibm.com/catalog/services/internet-of-things-platform
module "iot" {
  source = "./iot-platform"

  course_rg_id = module.course-setup.resource_group_id
  location     = var.location
  iot_name     = var.iot_name
  iot_plan     = var.iot_plan
}

# Machine Learning - https://cloud.ibm.com/catalog/services/machine-learning

module "ml" {
  source = "./machine-learning"

  course_rg_id = module.course-setup.resource_group_id
  location     = var.location
  ml_name      = var.ml_name
  ml_plan      = var.ml_plan
}


# Watson Studio - https://cloud.ibm.com/catalog/services/watson-studio
module "watson-studio" {
  source = "./watson-studio"

  course_rg_id = module.course-setup.resource_group_id
  location     = var.location
  ws_name      = var.ws_name
  ws_plan      = var.ws_plan
}
