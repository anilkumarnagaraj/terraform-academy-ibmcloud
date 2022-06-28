import requests
import json
import os
import time

TOKEN_URL = "https://iam.cloud.ibm.com/identity/token"
SCHEMATCIS_API = "https://us.schematics.cloud.ibm.com"
ERR_STATUS_CODE = [400, 401, 404, 403, 500, 502]
NONE_TYPE = type(None)

def get_tokens(apikey, add_user=True):
    refresh_token = ""
    access_token = ""
    # get access token form api-key
    if add_user:
        response = requests.post(TOKEN_URL, data={'grant_type': 'urn:ibm:params:oauth:grant-type:apikey', 'apikey': apikey}, auth=('bx', 'bx'))
    else:
        response = requests.post(TOKEN_URL, data={'grant_type': 'urn:ibm:params:oauth:grant-type:apikey', 'apikey': apikey})
    if response.status_code not in ERR_STATUS_CODE:
        #data = json.loads(response.json())
        data = response.json()
        refresh_token = data['refresh_token']
        access_token = 'Bearer ' + data['access_token']
    return access_token, refresh_token

def get_worksapce_info(access_token, workspace_id, retries=0):
    if retries > 10: return
    try:
        schematics_headers = {'Authorization' : access_token}
        response = requests.get(SCHEMATCIS_API+'/v1/workspaces/{}'.format(workspace_id), headers=schematics_headers)
        if type(response.json()) == NONE_TYPE:
                time.sleep(5)    
                retries+=1
                get_worksapce_info(access_token, workspace_id, retries)
        elif response.status_code not in ERR_STATUS_CODE:
            return response.json()
    except:
        time.sleep(5)    
        retries+=1
        get_worksapce_info(access_token, workspace_id, retries)
        

def apply_plan(ws_id, access_token, refresh_token, retries=0):
    if retries > 10: return
    try:
        schematics_headers = {
            'Authorization' : access_token,
            'refresh_token' : refresh_token
        }
        response = requests.put(SCHEMATCIS_API+'/v1/workspaces/{}/apply'.format(ws_id), headers=schematics_headers)
        if type(response.json()) == NONE_TYPE:
            time.sleep(5)    
            retries+=1
            apply_plan(ws_id, access_token, refresh_token, retries)
        elif response.status_code not in ERR_STATUS_CODE:
            data = response.json()
            return data
    except:
        time.sleep(5)    
        retries+=1
        apply_plan(ws_id, access_token, refresh_token, retries)

    
def get_job_info(access_token, job_id, retries=0):
    if retries > 10: return
    try:
        schematics_headers = {'Authorization' : access_token}
        response = requests.get(SCHEMATCIS_API+'/v2/jobs/{}'.format(job_id), headers=schematics_headers)
        if type(response.json()) == NONE_TYPE:
                time.sleep(5)    
                retries+=1
                get_job_info(access_token, job_id, retries)
        elif response.status_code not in ERR_STATUS_CODE:
            return response.json()
    except:
        time.sleep(5)    
        retries+=1
        get_job_info(access_token, job_id, retries)
    

def convert_dict_to_json(data):
    # Convert dict to str
    json_str = json.dumps(data, indent = 4) 
    # Convert string to json object
    json_object = json.loads(json_str)
    
    return json_object

def main():
    apikey = os.getenv('API_KEY')
    workspace_id = os.getenv('WORKSPACE_ID')
    job_index = os.getenv('JOB_ID')
   
    if  apikey == "" or workspace_id == "":
        print('No apikey or worspaces_id is provided!')
        return {"error" : "No apikey or worspaces_id is provided"}

    if not os.path.exists('/tmp/.schematics'):
        os.makedirs('/tmp/.schematics', exist_ok=True)

    access_token, refresh_token = get_tokens(apikey)
    if refresh_token == "" or access_token == "":
        print('Failed to fetch refresh and access tokens') 
        return {"error" : "Failed to fetch refresh and access tokens"}

    time.sleep(30)

     # Get schematics workspace details
    while True:  
        ws_info = get_worksapce_info(access_token, workspace_id)
        if type(ws_info) != NONE_TYPE and 'status' in ws_info:
            if ws_info['status'] == "INACTIVE" or ws_info['status'] == "ACTIVE" or ws_info['status'] == "FAILED":
                break
        time.sleep(2)

    # Apply plan on schematics workspace
    data = apply_plan(workspace_id, access_token, refresh_token)
    print("Response:", data, type(data))
    json_object = convert_dict_to_json(data)
    if type(json_object) != NONE_TYPE:
        job_id = json_object["activityid"]
    else:
         exit("Schematics apply plan failed to get response for job id.")   
    
    status = "provisioning"
    while status != "job_in_progress":
         # Get apply plan status
        job_data = get_job_info(access_token, job_id)
        if type(job_data) != NONE_TYPE:
            json_object = convert_dict_to_json(job_data)
            if type(json_object) != NONE_TYPE and 'status' in json_object:
                status = json_object["status"]["workspace_job_status"]["status_code"]
                if status == "job_failed":
                    exit("Schematics Apply Plan Failed.")
                elif status == "job_in_progress":  
                    with open(''.join(["/tmp/.schematics/job_info_", job_index, ".json"]), "w") as outfile:
                        json.dump(job_data, outfile)
    
    return {"info" : "Schematics apply plan initiated successfully."}


if __name__ == "__main__":
    main()