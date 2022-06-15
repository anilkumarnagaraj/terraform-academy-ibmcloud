#!/bin/bash

echo "************* setu[ ibmcloud schematics cli *****************"
ibmcloud plugin install schematics
sleep 10

echo "************* ibmcloud cli login *****************"
ibmcloud login --apikey=$API_KEY -a $ENDPOINT -r $REGION -g $RESOURCE_GROUP
sleep 10

echo "************* schematics apply *****************"
job_id=$(ibmcloud schematics apply --id $WORKSPACE_ID -f -j | jq -r '.activityid' 2>&1)
echo job_id=$job_id
sleep 10

status='provisioning'
echo $status
while [ "$status" != "job_finished" ]
do
  if [[ $(ibmcloud schematics job get --id $job_id -j | jq -r '.status.workspace_job_status.status_code') == *"job_finished"* ]]; then
    echo status = job_finished
    status="job_finished"

    # store job information 
    ibmcloud schematics job get --id $job_id -j > scripts/job_info.json 
    if [ $? == 0 ]; then
      echo "Created job information json file."
     else
      echo "Failed to get job information."
      exit $? 
    fi 
  elif [[ $(ibmcloud schematics job get --id $job_id -j | jq -r '.status.workspace_job_status.status_code') == *"job_failed"* ]]; then
      echo "Failed to provision workspace resource."
      exit 1 
  fi
   echo "************* provisioning resource *****************"
   sleep 10
done