#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

module "course_governance" {
  source = "./course-governance"

  ibmcloud_api_key                    = var.ibmcloud_api_key
  schematics_workspace_resource_group = var.schematics_workspace_resource_group
  invite_user_list                    = var.invite_user_list
  decomission_timer                   = var.decomission_timer
  create_bc                           = var.create_bc
  create_iot                          = var.create_iot
  create_ml                           = var.create_ml
  create_ws                           = var.create_ws
}