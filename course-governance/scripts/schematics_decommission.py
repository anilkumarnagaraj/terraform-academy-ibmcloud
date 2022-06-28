import requests
import json
import copy
import smtplib

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

def delete_workspace_resource(access_token, refresh_token, workspace_id):
    schematics_headers = {
        'Authorization' : access_token,
        'refresh_token' : refresh_token
    }
    print(SCHEMATCIS_API+'/v1/workspaces/{}/destroy'.format(workspace_id))
    response = requests.put(SCHEMATCIS_API+'/v1/workspaces/{}/destroy'.format(workspace_id), headers=schematics_headers)
    print(response)
    if response.status_code not in ERR_STATUS_CODE:
        return response.json()

def send_mail():
    sender = 'anilkumar@in.ibm.com'
    receivers = ['anilkumar@in.ibm.com']

    message = """From: No Reply <no_reply@mydomain.com>
    To: Person <person@otherdomain.com>
    Subject: Test Email

    This is a test e-mail message.
    """

    try:
        smtp_obj = smtplib.SMTP('localhost')
        smtp_obj.sendmail(sender, receivers, message)         
        print("Successfully sent email")
    except smtplib.SMTPException:
        print("Error: unable to send email")

def main(args):
    
    apikey = args['apikey']
    workspace_id = args['workspace_id']
    
    if  apikey == "" or workspace_id == "":
        print('No apikey or worspaces_id is provided!')
        return {"error" : "No apikey or worspaces_id is provided"}

    access_token, refresh_token = get_tokens(apikey)
    if refresh_token == "" or access_token == "":
        print('Failed to fetch refresh and access tokens') 
        return {"error" : "Failed to fetch refresh and access tokens"}
    
    # Delete schematics workspace resource
    #send_mail()
    response = delete_workspace_resource(access_token, refresh_token, workspace_id)
    return response
