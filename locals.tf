
/*
locals{
    everything = slice(var.invite_user_list, 0, 4  )
    butlast    = "${slice(var.invite_user_list, 4 , length(var.invite_user_list))}"
    #thelast    = "${slice(var.invite_user_list, length(var.invite_user_list)-1, length(var.invite_user_list)  )}"

    user_list = chunklist(var.invite_user_list, 8)
    workspace_1  = "${ length(chunklist(var.invite_user_list, 8))  1 ? slice(var.invite_user_list, 0, length(var.invite_user_list)  ) : [] }"
    workspace_2  = "${ length(chunklist(var.invite_user_list, 8)) == 2 ? slice(var.invite_user_list, 8, length(var.invite_user_list)  ) : [] }"
    #workspace_3  = "${ length(chunklist(var.invite_user_list, 8)) >= 3 ? slice(var.invite_user_list, 16, length(var.invite_user_list)  ) : [] }"
}

output "workspace_1" {
    value = local.workspace_1
}

output "workspace_2" {
    value = local.workspace_2
}
*/