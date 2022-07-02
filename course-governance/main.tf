#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

resource "ibm_resource_group" "rg" {
  name = "${var.course_prefix}-RG"
}

// Create schematics_workspace resource
resource "ibm_schematics_workspace" "schematics_workspace_instance" {
  for_each = {for i, v in var.invite_user_list:  i => v}

  location         = var.schematics_workspace_location
  name             = "${var.course_prefix}-workspace-${each.key}"
  resource_group   = "${var.course_prefix}-RG"
  template_type    = "terraform_v1.0"
  template_git_url = var.schematics_workspace_template_repo

  template_inputs {
    name  = "course_resource_group_id"
    type  = "string"
    value = "${ibm_resource_group.rg.id}"
  }

  template_inputs {
    name  = "course_prefix"
    type  = "string"
    value = "${var.course_prefix}-${each.value.name}"
  }

  template_inputs {
    name  = "accgrp_name"
    type  = "string"
    value = "tf-academy-training-AG-${each.key}"
  }

  template_inputs {
    name  = "invite_user_list"
    type  = "list(string)"
    value = "[\"${each.value.email}\"]"
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

  template_inputs {
    name  = "create_vsi"
    type  = "bool"
    value = var.create_vsi
  }

  template_inputs {
    name  = "image"
    type  = "string"
    value = var.image
  }

  template_inputs {
    name  = "profile"
    type  = "string"
    value = var.profile
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
  for_each = {for i, v in var.invite_user_list:  i => v}

  triggers = {
    API_KEY        = var.ibmcloud_api_key
    WORKSPACE_ID   = ibm_schematics_workspace.schematics_workspace_instance[each.key].id
  }

  provisioner "local-exec" {
    when    = create
    environment = {
      API_KEY        = var.ibmcloud_api_key
      WORKSPACE_ID   = ibm_schematics_workspace.schematics_workspace_instance[each.key].id
      JOB_ID         = each.key
    }

    command = "${path.module}/scripts/schematics_apply.py"
    interpreter = ["python3"]
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf /tmp/.schematics/job_info_${each.key}.json"
  }

}

// Read job information
data "local_file" "read_job" {
  for_each = {for i, v in var.invite_user_list:  i => v}
  filename = "/tmp/.schematics/job_info_${each.key}.json"
  depends_on = [null_resource.schematics_apply]
}

