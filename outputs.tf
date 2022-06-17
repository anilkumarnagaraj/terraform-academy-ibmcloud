#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

output "workspace_id" {
  description = "schematics workspace resource instance"
  value       = module.course_governance.*.workspace_id
}

output "job_id" {
  description = "Schematics workspace Apply Job Id"
  value       = module.course_governance.*.job_id
}

output "job_created_timer" {
  description = "schematics workspace resource created time"
  value       = module.course_governance.*.job_created_timestamp
}

output "job_decomission_timer" {
  description = "schematics workspace resource de-provision time"
  value       = module.course_governance.*.job_destroy_timestamp
}

output "cron_expr" {
  description = "Cron expression for cloud function trigger alarm"
  value       = module.course_governance.*.cron_expr
}