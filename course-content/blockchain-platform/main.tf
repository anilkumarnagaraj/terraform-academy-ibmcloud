#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

# Blockchain Platform - https://cloud.ibm.com/catalog/services/blockchain-platform
resource "ibm_resource_instance" "blockchain" {
  count             = var.create_bc ? 1 : 0
  name              = var.bch_name
  service           = "blockchain"
  plan              = var.bch_plan
  location          = var.location
  resource_group_id = var.course_rg_id
}
