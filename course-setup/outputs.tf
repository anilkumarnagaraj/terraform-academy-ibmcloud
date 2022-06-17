#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

output "resource_group_id" {
  value       = module.rg_setup.resource_group_id
  description = "Resource Group ID"
  sensitive   = false
}

output "resource_group_name" {
  value       = module.rg_setup.resource_group_name
  description = "Resource Group Name"
  sensitive   = false
}
