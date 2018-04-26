#!/usr/bin/env bash

#Assumes you have jq installed on the machine
#If you don't have jq installed - well, what's wrong with you ?!

clusterState=`aws emr describe-cluster --cluster-id ${clusterId} | jq -r '.Cluster.Status.State'`