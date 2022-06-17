#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

##########################################################
# IBM Authentication Variables
##########################################################

variable "ibmcloud_api_key" {
  description = "IBM Cloud API key"
  type        = string
}

variable "schematics_workspace_resource_group" {
  description = "The ID of the resource group where you want to provision the workspace."
  type        = string
}

##########################################################
# IBM Cloud Schematics Variables
##########################################################

variable "schematics_workspace_location" {
  description = "The location where you want to create your Schematics workspace and run Schematics actions. The location that you enter must match the API endpoint that you use. For example, if you use the Frankfurt API endpoint, you must specify `eu-de` as your location. If you use an API endpoint for a geography and you do not specify a location, Schematics determines the location based on availability."
  type        = string
  default     = "us-east"
}

variable "schematics_workspace_name" {
  description = "The name of your workspace. The name can be up to 128 characters long and can include alphanumeric characters, spaces, dashes, and underscores. When you create a workspace for your own Terraform template, consider including the microservice component that you set up with your Terraform template and the IBM Cloud environment where you want to deploy your resources in your name."
  type        = string
  default     = "academy-trainingworkspace"
}

variable "schematics_workspace_template_repo" {
  description = "Template repo to provision the cloud resource."
  type        = string
  default     = "https://github.com/Cloud-Schematics/terraform-academy-ibmcloud/tree/dev/course-content"
}

variable "invite_user_list" {
  type        = list(string)
  description = "Name of the Access Group used for Training in comma (,) seperated values"
  default     = ["user@testdomain.com"]
}

##########################################################
# IBM Cloud Functions Variables
##########################################################

variable "namespace" {
  description = "The name IAM based cloud function namespace."
  type        = string
  default     = "academy-trainingnamespace"
}

variable "action_name" {
  description = "Action name."
  type        = string
  default     = "schematics-cron"
}

variable "trigger_name" {
  description = "Trigger name."
  type        = string
  default     = "schematics-trigger"
}

variable "rule_name" {
  description = "Rule name."
  type        = string
  default     = "schematics-rule"
}

variable "decomission_timer" {
  description = "Time length to de-provision the resource after the creation.."
  type        = string
  default     = "4m"
}
