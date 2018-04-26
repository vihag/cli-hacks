#!/usr/bin/env bash

eval "(sh ./myScript.sh ${1} ${2}) &"

pid=$!
RUNNING_DAEMONS[${1}]=${pid}

for runningDaemon in "${!RUNNING_DAEMONS[@]}";
		do
			if [ -e /proc/${RUNNING_DAEMONS[runningDaemon]} ];then
				echo "Process ${RUNNING_DAEMONS[runningDaemon]} is running."
			else
				echo "Process ${RUNNING_DAEMONS[runningDaemon]} is complete."
      fi
		done