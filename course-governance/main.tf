#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

resource "ibm_resource_group" "rg" {
  name = "${var.course_prefix}-RG"
}

// Create schematics_workspace resource
resource "ibm_schematics_workspace" "schematics_workspace_instance_1" {
  for_each = { for i, v in local.workspace_batch_list[0] : i => v }

  location         = var.schematics_workspace_location
  name             = "${var.course_prefix}-b1-${each.key}"
  resource_group   = "${var.course_prefix}-RG"
  template_type    = "terraform_v1.0"
  template_git_url = var.schematics_workspace_template_repo

  template_inputs {
    name  = "ibmcloud_api_key"
    type  = "string"
    value = "${each.value.apikey}"
  }

  template_inputs {
    name  = "course_resource_group_id"
    type  = "string"
    value = ibm_resource_group.rg.id
  }

  template_inputs {
    name  = "course_prefix"
    type  = "string"
    value = "${var.course_prefix}-${each.value.name}"
  }

  template_inputs {
    name  = "accgrp_name"
    type  = "string"
    value = "${var.course_prefix}-AG-${each.key}"
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
    name  = "bch_plan"
    type  = "string"
    value = var.bch_plan
  }

  template_inputs {
    name  = "create_iot"
    type  = "bool"
    value = var.create_iot
  }

  template_inputs {
    name  = "iot_plan"
    type  = "string"
    value = var.iot_plan
  }

  template_inputs {
    name  = "create_ml"
    type  = "bool"
    value = var.create_ml
  }

  template_inputs {
    name  = "ml_plan"
    type  = "string"
    value = var.ml_plan
  }

  template_inputs {
    name  = "create_ws"
    type  = "bool"
    value = var.create_ws
  }

  template_inputs {
    name  = "ws_plan"
    type  = "string"
    value = var.ws_plan
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
      resource_group,
    ]
  }

}

resource "time_sleep" "wait_30_seconds" {
  depends_on      = [ibm_schematics_workspace.schematics_workspace_instance_1]
  create_duration = "30s"
}

resource "ibm_schematics_workspace" "schematics_workspace_instance_2" {
  for_each = { for i, v in length(local.workspace_batch_list) >= 2 ? local.workspace_batch_list[1] : [] : i => v }

  location         = var.schematics_workspace_location
  name             = "${var.course_prefix}-b2-${each.key}"
  resource_group   = "default"
  template_type    = "terraform_v1.0"
  template_git_url = var.schematics_workspace_template_repo

  template_inputs {
    name  = "ibmcloud_api_key"
    type  = "string"
    value = "${each.value.apikey}"
  }

  template_inputs {
    name  = "course_resource_group_id"
    type  = "string"
    value = ibm_resource_group.rg.id
  }

  template_inputs {
    name  = "course_prefix"
    type  = "string"
    value = "${var.course_prefix}-${each.value.name}"
  }

  template_inputs {
    name  = "accgrp_name"
    type  = "string"
    value = "${var.course_prefix}-AG-${each.key}"
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
    name  = "bch_plan"
    type  = "string"
    value = var.bch_plan
  }

  template_inputs {
    name  = "create_iot"
    type  = "bool"
    value = var.create_iot
  }

  template_inputs {
    name  = "iot_plan"
    type  = "string"
    value = var.iot_plan
  }

  template_inputs {
    name  = "create_ml"
    type  = "bool"
    value = var.create_ml
  }

  template_inputs {
    name  = "ml_plan"
    type  = "string"
    value = var.ml_plan
  }

  template_inputs {
    name  = "create_ws"
    type  = "bool"
    value = var.create_ws
  }

  template_inputs {
    name  = "ws_plan"
    type  = "string"
    value = var.ws_plan
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
      resource_group,
    ]
  }

  depends_on = [time_sleep.wait_30_seconds]
}

resource "time_sleep" "wait_30_seconds_2" {
  depends_on      = [time_sleep.wait_30_seconds, ibm_schematics_workspace.schematics_workspace_instance_2]
  create_duration = "30s"
}

resource "ibm_schematics_workspace" "schematics_workspace_instance_3" {
  for_each = { for i, v in length(local.workspace_batch_list) >= 3 ? local.workspace_batch_list[2] : [] : i => v }

  location         = var.schematics_workspace_location
  name             = "${var.course_prefix}-b3-${each.key}"
  resource_group   = "default"
  template_type    = "terraform_v1.0"
  template_git_url = var.schematics_workspace_template_repo

  template_inputs {
    name  = "ibmcloud_api_key"
    type  = "string"
    value = "${each.value.apikey}"
  }

  template_inputs {
    name  = "course_resource_group_id"
    type  = "string"
    value = ibm_resource_group.rg.id
  }

  template_inputs {
    name  = "course_prefix"
    type  = "string"
    value = "${var.course_prefix}-${each.value.name}"
  }

  template_inputs {
    name  = "accgrp_name"
    type  = "string"
    value = "${var.course_prefix}-AG-${each.key}"
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
    name  = "bch_plan"
    type  = "string"
    value = var.bch_plan
  }

  template_inputs {
    name  = "create_iot"
    type  = "bool"
    value = var.create_iot
  }

  template_inputs {
    name  = "iot_plan"
    type  = "string"
    value = var.iot_plan
  }

  template_inputs {
    name  = "create_ml"
    type  = "bool"
    value = var.create_ml
  }

  template_inputs {
    name  = "ml_plan"
    type  = "string"
    value = var.ml_plan
  }

  template_inputs {
    name  = "create_ws"
    type  = "bool"
    value = var.create_ws
  }

  template_inputs {
    name  = "ws_plan"
    type  = "string"
    value = var.ws_plan
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
      resource_group,
    ]
  }

  depends_on = [time_sleep.wait_30_seconds_2]
}

resource "time_sleep" "wait_30_seconds_3" {
  depends_on      = [time_sleep.wait_30_seconds_2, ibm_schematics_workspace.schematics_workspace_instance_3]
  create_duration = "30s"
}

resource "ibm_schematics_workspace" "schematics_workspace_instance_4" {
  for_each = { for i, v in length(local.workspace_batch_list) >= 4 ? local.workspace_batch_list[3] : [] : i => v }

  location         = var.schematics_workspace_location
  name             = "${var.course_prefix}-b4-${each.key}"
  resource_group   = "default"
  template_type    = "terraform_v1.0"
  template_git_url = var.schematics_workspace_template_repo

  template_inputs {
    name  = "ibmcloud_api_key"
    type  = "string"
    value = "${each.value.apikey}"
  }

  template_inputs {
    name  = "course_resource_group_id"
    type  = "string"
    value = ibm_resource_group.rg.id
  }

  template_inputs {
    name  = "course_prefix"
    type  = "string"
    value = "${var.course_prefix}-${each.value.name}"
  }

  template_inputs {
    name  = "accgrp_name"
    type  = "string"
    value = "${var.course_prefix}-AG-${each.key}"
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
    name  = "bch_plan"
    type  = "string"
    value = var.bch_plan
  }

  template_inputs {
    name  = "create_iot"
    type  = "bool"
    value = var.create_iot
  }

  template_inputs {
    name  = "iot_plan"
    type  = "string"
    value = var.iot_plan
  }

  template_inputs {
    name  = "create_ml"
    type  = "bool"
    value = var.create_ml
  }

  template_inputs {
    name  = "ml_plan"
    type  = "string"
    value = var.ml_plan
  }

  template_inputs {
    name  = "create_ws"
    type  = "bool"
    value = var.create_ws
  }

  template_inputs {
    name  = "ws_plan"
    type  = "string"
    value = var.ws_plan
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
      resource_group,
    ]
  }

  depends_on = [time_sleep.wait_30_seconds_3]
}

resource "time_sleep" "wait_30_seconds_4" {
  depends_on      = [time_sleep.wait_30_seconds_2, ibm_schematics_workspace.schematics_workspace_instance_3, ibm_schematics_workspace.schematics_workspace_instance_4]
  create_duration = "30s"
}

resource "ibm_schematics_workspace" "schematics_workspace_instance_5" {
  for_each = { for i, v in length(local.workspace_batch_list) >= 5 ? local.workspace_batch_list[4] : [] : i => v }

  location         = var.schematics_workspace_location
  name             = "${var.course_prefix}-b5-${each.key}"
  resource_group   = "default"
  template_type    = "terraform_v1.0"
  template_git_url = var.schematics_workspace_template_repo

  template_inputs {
    name  = "ibmcloud_api_key"
    type  = "string"
    value = "${each.value.apikey}"
  }

  template_inputs {
    name  = "course_resource_group_id"
    type  = "string"
    value = ibm_resource_group.rg.id
  }

  template_inputs {
    name  = "course_prefix"
    type  = "string"
    value = "${var.course_prefix}-${each.value.name}"
  }

  template_inputs {
    name  = "accgrp_name"
    type  = "string"
    value = "${var.course_prefix}-AG-${each.key}"
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
    name  = "bch_plan"
    type  = "string"
    value = var.bch_plan
  }

  template_inputs {
    name  = "create_iot"
    type  = "bool"
    value = var.create_iot
  }

  template_inputs {
    name  = "iot_plan"
    type  = "string"
    value = var.iot_plan
  }

  template_inputs {
    name  = "create_ml"
    type  = "bool"
    value = var.create_ml
  }

  template_inputs {
    name  = "ml_plan"
    type  = "string"
    value = var.ml_plan
  }

  template_inputs {
    name  = "create_ws"
    type  = "bool"
    value = var.create_ws
  }

  template_inputs {
    name  = "ws_plan"
    type  = "string"
    value = var.ws_plan
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
      resource_group,
    ]
  }

  depends_on = [time_sleep.wait_30_seconds_4]
}

// Provision resource
resource "null_resource" "schematics_apply" {
  triggers = {
    API_KEY       = var.ibmcloud_api_key
    WORKSPACE_IDS = "${jsonencode(local.workspace_ids)}"
  }

  provisioner "local-exec" {
    when    = create
    command = "python3 ${path.module}/scripts/schematics_apply.py '${base64encode(var.ibmcloud_api_key)}' '${base64encode(jsonencode(local.workspace_ids))}' '${base64encode(jsonencode(var.invite_user_list))}'"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf /tmp/.schematics/job_info_*"
  }

  depends_on = [time_sleep.wait_30_seconds, time_sleep.wait_30_seconds_2, time_sleep.wait_30_seconds_3, ibm_schematics_workspace.schematics_workspace_instance_3, ibm_schematics_workspace.schematics_workspace_instance_4, ibm_schematics_workspace.schematics_workspace_instance_5]
}

// Read job information
data "local_file" "read_job" {
  for_each = { for i, v in var.invite_user_list : i => v }
  filename = "/tmp/.schematics/job_info_${each.key}.json"

  depends_on = [null_resource.schematics_apply]
}
