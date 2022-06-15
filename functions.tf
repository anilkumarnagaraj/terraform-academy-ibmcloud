data "ibm_resource_group" "resource-group" {
   name = var.schematics_workspace_resource_group
}

resource "ibm_function_namespace" "namespace" {
   name                = var.namespace
   resource_group_id   = data.ibm_resource_group.resource-group.id
}

resource "ibm_function_action" "action" {
  name      = var.action_name
  namespace = ibm_function_namespace.namespace.name
  
  exec {
    kind = "python:3.9"
    code = file("${path.module}/scripts/main.py")
  }

  depends_on = [data.local_file.read_job]
}

resource "ibm_function_trigger" "trigger" {
  name      = var.trigger_name
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
	   		"value":"${ibm_schematics_workspace.schematics_workspace_instance.id}"
	  	}
	   ]
	EOF

  depends_on = [ibm_function_action.action]
}

resource "ibm_function_rule" "rule" {
  name         = var.rule_name
  namespace    = ibm_function_namespace.namespace.name
  trigger_name = ibm_function_trigger.trigger.name
  action_name  = ibm_function_action.action.name
}