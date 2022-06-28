#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

output "machine-learning-dashboard-url" {
  value       = var.create_ml ? concat(ibm_resource_instance.pm-20.*.dashboard_url, [""])[0] : ""
  description = "Machine Learning Service Dashboard URL"
  sensitive   = false
}


