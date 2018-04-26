#!/usr/bin/env bash

taskStatus=`curl http://${OVERLORD_IP}:${OVERLORD_PORT}/druid/indexer/v1/task/${taskId}/status | jq --raw-output '.["status"] | {status} | .[]'`
	#Three possible return states from Coordinator(https://github.com/druid-io/druid/blob/master/indexing-service/src/main/java/io/druid/indexing/common/TaskStatus.java)
	success="SUCCESS"
	running="RUNNING"
	failed="FAILED"
	while [[ "$taskStatus" != "$success" && "$taskStatus" != "$failed" ]]
  		do
    			INFO "$taskId is not completed yet"
    			sleep 60
    			taskStatus=`curl http://${OVERLORD_IP}:${OVERLORD_PORT}/druid/indexer/v1/task/${taskId}/status | jq --raw-output '.["status"] | {status} | .[]'`
  		done
	INFO "${taskId} is completed with status ${taskStatus}"