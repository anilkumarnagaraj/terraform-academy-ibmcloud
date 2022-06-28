#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

// Create schematics_workspace resource
resource "ibm_schematics_workspace" "schematics_workspace_instance" {
  count            = length(var.invite_user_list)

  location         = var.schematics_workspace_location
  name             = "${var.schematics_workspace_name}-${count.index}"
  resource_group   = "${var.schematics_workspace_resource_group}"
  template_type    = "terraform_v0.13.5"
  template_git_url = var.schematics_workspace_template_repo


  template_inputs {
    name  = "course_rg_name"
    type  = "string"
    value = "tf-academy-training-RG-${count.index}"
  }

  template_inputs {
    name  = "accgrp_name"
    type  = "string"
    value = "tf-academy-training-AG-${count.index}"
  }

  template_inputs {
    name  = "invite_user_list"
    type  = "list(string)"
    value = local.invite_list
  }

  template_inputs {
    name  = "create_bc"
    type  = "bool"
    value = var.create_bc
  }

  template_inputs {
    name  = "create_iot"
    type  = "bool"
    value = var.create_iot
  }

  template_inputs {
    name  = "create_ml"
    type  = "bool"
    value = var.create_ml
  }

  template_inputs {
    name  = "create_ws"
    type  = "bool"
    value = var.create_ws
  }

  lifecycle {
    ignore_changes = [
      template_git_url,
      template_git_folder,
      template_git_branch,
    ]
  }

}

// Provision resource
resource "null_resource" "schematics_apply" {
  count            = length(var.invite_user_list)

  triggers = {
    API_KEY        = var.ibmcloud_api_key
    WORKSPACE_ID   = ibm_schematics_workspace.schematics_workspace_instance[count.index].id
  }

  provisioner "local-exec" {
    when    = create
    environment = {
      API_KEY        = var.ibmcloud_api_key
      WORKSPACE_ID   = ibm_schematics_workspace.schematics_workspace_instance[count.index].id
      JOB_ID         = count.index
    }

    command = "${path.module}/scripts/schematics_apply.py"
    interpreter = ["python3"]
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf /tmp/.schematics/job_info.json"
  }


}

// Read job information
data "local_file" "read_job" {
  count = 1
  filename = "/tmp/.schematics/job_info.json"
  depends_on = [null_resource.schematics_apply]
}

