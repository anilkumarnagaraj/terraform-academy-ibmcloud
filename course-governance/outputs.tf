#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

output "workspace_id" {
  value       = ibm_schematics_workspace.schematics_workspace_instance.*.id
  description = "schematics_workspace resource instance"
}

output "job_id" {
  value = local.data.id
}

output "job_created_timestamp" {
  value = local.data.end_at
}

output "job_destroy_timestamp" {
  value = local.job_destroy_timestamp
}

output "cron_expr" {
  value = local.cron_expr
}