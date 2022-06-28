#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

resource "ibm_resource_group" "rg" {
  name = var.training_rg_name
}

// Create schematics_workspace resource
resource "ibm_schematics_workspace" "schematics_workspace_instance_1" {
  for_each = {for i, v in local.user_list[0]:  i => v}

  location         = var.schematics_workspace_location
  name             = "${var.schematics_workspace_name}-${each.key}"
  resource_group   = var.training_rg_name
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

resource "time_sleep" "wait_30_seconds" {
  depends_on = [ibm_schematics_workspace.schematics_workspace_instance_1]
  create_duration = "30s"
}

resource "ibm_schematics_workspace" "schematics_workspace_instance_2" {
  for_each =  {for i, v in length(local.user_list) >= 2 ? local.user_list[1] : []  :  i => v}

  location         = var.schematics_workspace_location
  name             = "${var.schematics_workspace_name}-${each.key}"
  resource_group   = var.training_rg_name
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

  depends_on = [time_sleep.wait_30_seconds]
}

resource "time_sleep" "wait_30_seconds_2" {
  depends_on = [ibm_schematics_workspace.schematics_workspace_instance_2]
  create_duration = "30s"
}

resource "ibm_schematics_workspace" "schematics_workspace_instance_3" {
  for_each =  {for i, v in length(local.user_list) >= 3 ? local.user_list[2] : []  :  i => v}

  location         = var.schematics_workspace_location
  name             = "${var.schematics_workspace_name}-${each.key}"
  resource_group   = var.training_rg_name
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

  depends_on = [time_sleep.wait_30_seconds_2]
}

resource "time_sleep" "wait_30_seconds_3" {
  depends_on = [ibm_schematics_workspace.schematics_workspace_instance_3]

  create_duration = "30s"
}

resource "ibm_schematics_workspace" "schematics_workspace_instance_4" {
  for_each =  {for i, v in length(local.user_list) >= 4 ? local.user_list[3] : []  :  i => v}

  location         = var.schematics_workspace_location
  name             = "${var.schematics_workspace_name}-${each.key}"
  resource_group   = var.training_rg_name
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

  depends_on = [time_sleep.wait_30_seconds_3]
}

// Provision resource
resource "null_resource" "schematics_apply_1" {
  for_each = {for i, v in length(local.user_list) == 1 ? local.user_list[0] : []:  i => v}

  triggers = {
    API_KEY        = var.ibmcloud_api_key
    WORKSPACE_ID   = ibm_schematics_workspace.schematics_workspace_instance_1[each.key].id
  }

  provisioner "local-exec" {
    when    = create
    environment = {
      API_KEY        = var.ibmcloud_api_key
      WORKSPACE_ID   = ibm_schematics_workspace.schematics_workspace_instance_1[each.key].id
      JOB_ID         = each.key
    }

    command = "${path.module}/scripts/schematics_apply.py"
    interpreter = ["python3"]
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf /tmp/.schematics/job_info_${each.key}.json"
  }

  depends_on = [ibm_schematics_workspace.schematics_workspace_instance_1, ibm_schematics_workspace.schematics_workspace_instance_2, ibm_schematics_workspace.schematics_workspace_instance_3]

}

resource "null_resource" "schematics_apply_2" {
  for_each = {for i, v in length(local.user_list) >= 2 ? local.user_list[1] : []:  i => v}

  triggers = {
    API_KEY        = var.ibmcloud_api_key
    WORKSPACE_ID   = ibm_schematics_workspace.schematics_workspace_instance_2[each.key].id
  }

  provisioner "local-exec" {
    when    = create
    environment = {
      API_KEY        = var.ibmcloud_api_key
      WORKSPACE_ID   = ibm_schematics_workspace.schematics_workspace_instance_2[each.key].id
      JOB_ID         = each.key
    }

    command = "${path.module}/scripts/schematics_apply.py"
    interpreter = ["python3"]
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf /tmp/.schematics/job_info_${each.key}.json"
  }

  depends_on = [ibm_schematics_workspace.schematics_workspace_instance_1, ibm_schematics_workspace.schematics_workspace_instance_2, ibm_schematics_workspace.schematics_workspace_instance_3, ibm_schematics_workspace.schematics_workspace_instance_4]
}

resource "null_resource" "schematics_apply_3" {
  for_each = {for i, v in length(local.user_list) >= 3 ? local.user_list[2] : []:  i => v}

  triggers = {
    API_KEY        = var.ibmcloud_api_key
    WORKSPACE_ID   = ibm_schematics_workspace.schematics_workspace_instance_3[each.key].id
  }

  provisioner "local-exec" {
    when    = create
    environment = {
      API_KEY        = var.ibmcloud_api_key
      WORKSPACE_ID   = ibm_schematics_workspace.schematics_workspace_instance_3[each.key].id
      JOB_ID         = each.key
    }

    command = "${path.module}/scripts/schematics_apply.py"
    interpreter = ["python3"]
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf /tmp/.schematics/job_info_${each.key}.json"
  }

  depends_on = [ibm_schematics_workspace.schematics_workspace_instance_1, ibm_schematics_workspace.schematics_workspace_instance_2, ibm_schematics_workspace.schematics_workspace_instance_3, ibm_schematics_workspace.schematics_workspace_instance_4]
}

// Read job information
data "local_file" "read_job" {
  for_each = {for i, v in var.invite_user_list:  i => v}
  filename = "/tmp/.schematics/job_info_${each.key}.json" 

  depends_on = [null_resource.schematics_apply_1, null_resource.schematics_apply_2, null_resource.schematics_apply_3]
}