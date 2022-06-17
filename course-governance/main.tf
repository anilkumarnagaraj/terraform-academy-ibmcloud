#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

// Create schematics_workspace resource
resource "ibm_schematics_workspace" "schematics_workspace_instance" {
  location         = var.schematics_workspace_location
  name             = var.schematics_workspace_name
  resource_group   = var.schematics_workspace_resource_group
  template_type    = "terraform_v0.13.5"
  template_git_url = var.schematics_workspace_template_repo
  template_inputs {
    name  = "invite_user_list"
    type  = "list(string)"
    value = "[\"user@testdomain.com\", \"user@testdomain.com\"]"
  }
}

// Provision resource
resource "null_resource" "schematics_apply" {

  triggers = {
    API_KEY        = var.ibmcloud_api_key
    REGION         = var.schematics_workspace_location
    RESOURCE_GROUP = var.schematics_workspace_resource_group
    ENDPOINT       = "cloud.ibm.com"
    WORKSPACE_ID   = ibm_schematics_workspace.schematics_workspace_instance.id
  }

  provisioner "local-exec" {
    when    = create
    command = "${path.module}/scripts/schematics_apply.sh"

    environment = {
      API_KEY        = var.ibmcloud_api_key
      REGION         = var.schematics_workspace_location
      RESOURCE_GROUP = var.schematics_workspace_resource_group
      ENDPOINT       = "cloud.ibm.com"
      WORKSPACE_ID   = ibm_schematics_workspace.schematics_workspace_instance.id
    }
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf job_info.json"
  }

}

// Read job information
data "local_file" "read_job" {
  filename = "job_info.json"

  depends_on = [null_resource.schematics_apply]
}

