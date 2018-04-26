#!/usr/bin/env bash

createClusterResponse=$(aws emr create-cluster  \
--applications Name=Hadoop  \
--tags 'key=value key=value key=value' \
--ec2-attributes '{"KeyName":"__key_name__","InstanceProfile":"EMR_EC2_DefaultRole","SubnetId":"__subnet_id__","EmrManagedSlaveSecurityGroup":"__slave_security_group__","EmrManagedMasterSecurityGroup":"__master_security_group__"}' \
--release-label emr-5.8.0 \
--log-uri 's3n://'${S3_BUCKET}'/data_pipeline_logs/' \
--steps '[{"Args":["s3://'${S3_BUCKET}'/bootstrapScripts/bootstrappers/bootstrapper.sh"],"Type":"CUSTOM_JAR","ActionOnFailure":"TERMINATE_CLUSTER","Jar":"s3://ap-southeast-2.elasticmapreduce/libs/script-runner/script-runner.jar","Properties":"","Name":"Custom JAR"}]'  \
--instance-groups '[{"InstanceCount":8,"BidPrice":"1.596","InstanceGroupType":"CORE","InstanceType":"r3.4xlarge","Name":"Core - 2"},{"InstanceCount":1,"InstanceGroupType":"MASTER","InstanceType":"m3.xlarge","Name":"Master - 1"}]' \
--auto-scaling-role EMR_AutoScaling_DefaultRole \
--service-role EMR_DefaultRole  \
--enable-debugging  \
--configurations '[{"Classification":"yarn-site","Properties":{"mapreduce.reduce.memory.mb":"6144","mapreduce.reduce.java.opts":"server -Xms2g -Xmx2g -Duser.timezone=UTC -Dfile.encoding=UTF-8 -XX:+PrintGCDetails -XX:+PrintGCTimeStamps","mapreduce.map.java.opts":"-server -Xms512m -Xmx512m -Duser.timezone=UTC -Dfile.encoding=UTF-8 -XX:+PrintGCDetails -XX:+PrintGCTimeStamps","mapreduce.task.timeout":"1800000"},"Configurations":[]},{"Classification":"mapred-site","Properties":{"mapreduce.map.output.compress":"true","mapreduce.map.output.compress.codec":"org.apache.hadoop.io.compress.SnappyCodec"},"Configurations":[]},{"Classification":"hdfs-site","Properties":{"dfs.replication":"1"},"Configurations":[]}]'    \
--name 'EMRIndexerForDruidForDate'$dateBeingIndexed  \
--scale-down-behavior TERMINATE_AT_INSTANCE_HOUR  \
--region ap-southeast-2	\
--ebs-root-volume-size 100)

clusterId=$(echo "${createClusterResponse}" | jq -r '.ClusterId')
INFO "EMR Cluster created with ID : $clusterId"
expectedClusterState="WAITING"
terminatedClusterState="TERMINATED_WITH_ERRORS"

# Block until the EMR cluster is in WAITING state, thats when we can supply the Druid Indexing Job
clusterState=''
while [ "$clusterState" != "$expectedClusterState" ]
do

  clusterState=`aws emr describe-cluster --cluster-id ${clusterId} | jq -r '.Cluster.Status.State'`

  if [ "$clusterState" == "$terminatedClusterState" ]
	then
		INFO "EMR $clusterId has $terminatedClusterState, will now retry to create another EMR cluster"
		clusterId=
		break
	else
		INFO "EMR $clusterId is in state : "$clusterState

  fi

  sleep 10

done
EXIT
echo "$clusterId"