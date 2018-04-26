#!/usr/bin/env bash

STEP_ID=` aws emr add-steps --cluster-id ${CLUSTER_ID} --steps Type=spark,Name=${NAME},Args=[--deploy-mode,cluster,--master,yarn,--driver-memory,10g,--num-executors,48,--executor-cores,2,--executor-memory,15g,--files,${file},--class,${class},${JAR},--arg-key,arg-value,--arg-key,arg-value,--arg-key,arg-value],ActionOnFailure=CONTINUE | jq -r .StepIds[0]`