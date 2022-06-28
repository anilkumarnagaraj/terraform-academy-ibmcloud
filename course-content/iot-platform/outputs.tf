#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

output "iot-service-dashboard-url" {
  value       = var.create_iot ? concat(ibm_resource_instance.iotf-service.*.dashboard_url, [""])[0] : ""
  description = "IOT Service Dashboard URL"
  sensitive   = false
}

