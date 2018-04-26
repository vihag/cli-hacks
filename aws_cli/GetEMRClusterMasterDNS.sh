#!/usr/bin/env bash

#Obtain the instance ID of the master node
masterInstanceID=`aws emr list-instances --cluster-id ${clusterId} --instance-group-types "MASTER" | jq -r '.Instances[0].Ec2InstanceId'`

INFO "EMR Master Instance ID : ${masterInstanceID}"

#Obtain the internal DNS of the master instance
masterInstancePrivateDNS=`aws ec2 describe-instances --instance-ids ${masterInstanceID} | jq -r '.Reservations[0].Instances[0].PrivateDnsName'`
INFO "EMR Master Instance Private DNS : ${masterInstancePrivateDNS}"