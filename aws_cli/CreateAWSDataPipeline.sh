#!/usr/bin/env bash

INFO "Spawning a new AWS Data pipeline"
createPipelineIdResponse=$(aws datapipeline create-pipeline --name ${PIPELINE_NAME} --unique-id ${PIPELINE_UNIQUE_ID})
pipelineId=$(echo "${createPipelineIdResponse}" | jq -r '.pipelineId')
INFO "Spawned a new AWS Data-pipeline with ID : $pipelineId"

INFO "Adding tracking tags to the AWS Data-pipeline $pipelineId => key=my_key,value=my_value"
aws datapipeline add-tags --pipeline-id ${pipelineId} --tags key=my_key,value=my_value key=my_key,value=my_value key=my_key,value=my_value

INFO "Adding definition to the AWS Data-pipleine $pipelineId"
pipelineJsonFile="/pipeline.json"

addPipelineDefinitionResponse=$(aws datapipeline put-pipeline-definition --pipeline-id ${pipelineId} --pipeline-definition file://${pipelineJsonFile})

validationErrors=$(echo "${addPipelineDefinitionResponse}" | jq -r '.validationErrors')
errored=$(echo "${addPipelineDefinitionResponse}" | jq -r '.errored')
validationWarnings=$(echo "${addPipelineDefinitionResponse}" | jq -r '.validationWarnings')