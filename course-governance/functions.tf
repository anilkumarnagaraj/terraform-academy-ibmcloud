#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

data "ibm_resource_group" "resource-group" {
  name = var.schematics_workspace_resource_group
}

resource "ibm_function_namespace" "namespace" {
  name              = var.namespace
  resource_group_id = data.ibm_resource_group.resource-group.id
}

resource "ibm_function_action" "action" {
  name      = var.action_name
  namespace = ibm_function_namespace.namespace.name

  exec {
    kind = "python:3.9"
    code = file("${path.module}/scripts/schematics_decommission.py")
  }
}

resource "ibm_function_trigger" "trigger" {
  count     = length(var.invite_user_list)

  name      = "${var.trigger_name}-${count.index}"
  namespace = ibm_function_namespace.namespace.name
  feed {
    name       = "/whisk.system/alarms/alarm"
    parameters = <<EOF
		[
			{
				"key":"cron",
				"value":"${local.cron_expr}"
			}
		]
	EOF
  }

  user_defined_parameters = <<EOF
	   [
	  	{
	   		"key":"apikey",
	   		"value":"${var.ibmcloud_api_key}"
	  	},
      {
	   		"key":"workspace_id",
	   		"value":"${ibm_schematics_workspace.schematics_workspace_instance[count.index].id}"
	  	}
	   ]
	EOF

  depends_on = [ibm_function_action.action]
}

resource "ibm_function_rule" "rule" {
  count        = length(var.invite_user_list)

  name         = "${var.rule_name}-${count.index}"
  namespace    = ibm_function_namespace.namespace.name
  trigger_name = ibm_function_trigger.trigger[count.index].name
  action_name  = ibm_function_action.action.name
}