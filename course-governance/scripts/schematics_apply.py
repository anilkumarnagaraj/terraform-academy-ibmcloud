import requests
import json
import os
import time

TOKEN_URL = "https://iam.cloud.ibm.com/identity/token"
SCHEMATCIS_API = "https://us.schematics.cloud.ibm.com"
ERR_STATUS_CODE = [400, 404, 403, 500, 502]

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

def apply_plan(ws_id, access_token, refresh_token, retries=0):
    if retries > 10: return
    try:
        schematics_headers = {
            'Authorization' : access_token,
            'refresh_token' : refresh_token
        }
        response = requests.put(SCHEMATCIS_API+'/v1/workspaces/{}/apply'.format(ws_id), headers=schematics_headers)
        if response.status_code not in ERR_STATUS_CODE:
            data = response.json()
            return data
    except:
        time.sleep(3)    
        retries+=1
        apply_plan(ws_id, access_token, refresh_token, retries)

    
def get_job_info(access_token, job_id, retries=0):
    if retries > 10: return
    try:
        schematics_headers = {'Authorization' : access_token}
        response = requests.get(SCHEMATCIS_API+'/v2/jobs/{}'.format(job_id), headers=schematics_headers)
        if response.status_code not in ERR_STATUS_CODE:
            return response.json()
    except:
        time.sleep(3)    
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

    access_token, refresh_token = get_tokens(apikey)
    if refresh_token == "" or access_token == "":
        print('Failed to fetch refresh and access tokens') 
        return {"error" : "Failed to fetch refresh and access tokens"}

    time.sleep(60)    
    # Apply plan on schematics workspace
    data = apply_plan(workspace_id, access_token, refresh_token)
    json_object = convert_dict_to_json(data)
    job_id = json_object["activityid"]

    status = "provisioning"
    while status != "job_finished":
         # Get apply plan job information
        job_data = get_job_info(access_token, job_id)
        json_object = convert_dict_to_json(job_data)
        status = json_object["status"]["workspace_job_status"]["status_code"]
        if status == "job_failed":
            exit("Schematics Apply Plan Failed.")
        elif status == "job_finished":  
            if not os.path.exists('/tmp/.schematics'):
                os.makedirs('/tmp/.schematics')
            with open(''.join(["/tmp/.schematics/job_info", job_index, ".json"]), "w") as outfile:
                json.dump(job_data, outfile)

    
    return {"info" : "Schematics apply plan completed."}


if __name__ == "__main__":
    main()