#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

locals {
  #invite_list = format("[\"%s\"]", join("\", \"", var.invite_user_list))
  
  activity_list = [
  for idx, prop in var.invite_user_list:
    { 
      prop = { 
        "apikey"                = prop["apikey"]
        "index"                 = idx
        "workspace_id"          = jsondecode(data.local_file.read_job[idx].content).command_object_id 
        "start_at"                = jsondecode(data.local_file.read_job[idx].content).start_at 
        "job_destroy_timestamp" = timeadd(formatdate("YYYY-MM-DD'T'hh:mm:ssZ", jsondecode(data.local_file.read_job[idx].content).start_at ), var.decomission_timer)
        "cron_expr"             = format("%s %s %s * *", substr(timeadd(formatdate("YYYY-MM-DD'T'hh:mm:ssZ", jsondecode(data.local_file.read_job[idx].content).start_at), var.decomission_timer), 14, 2), substr(timeadd(formatdate("YYYY-MM-DD'T'hh:mm:ssZ", jsondecode(data.local_file.read_job[idx].content).start_at), var.decomission_timer), 11, 2), substr(timeadd(formatdate("YYYY-MM-DD'T'hh:mm:ssZ", jsondecode(data.local_file.read_job[idx].content).start_at), var.decomission_timer), 8, 2))
      }
    }
  ]
}
