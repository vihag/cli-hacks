#!/usr/bin/env bash

STATE=`aws emr describe-step --cluster-id ${CLUSTER_ID} --step-id ${STEP_ID} | jq -r .Step.Status.State`