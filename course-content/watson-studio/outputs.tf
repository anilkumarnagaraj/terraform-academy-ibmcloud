#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

output "watson-studio-dashboard-url" {
  value       = var.create_ws ? concat(ibm_resource_instance.data-science-experience.*.dashboard_url, [""])[0] : ""
  description = "Watson Studio Dashboard URL"
  sensitive   = false
}