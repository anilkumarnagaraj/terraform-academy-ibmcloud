#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

output "blockchain-dashboard-url" {
  value       = var.create_bc ? concat(ibm_resource_instance.blockchain.*.dashboard_url, [""])[0] : ""
  description = "blockchain Service Dashboard URL"
  sensitive   = false
}