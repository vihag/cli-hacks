#!/usr/bin/env bash

minifiedJson=$(cat ${prettyJson} | jq -c .)