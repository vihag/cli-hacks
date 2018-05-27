#!/usr/bin/env bash

spark2-submit \
--master yarn \
--deploy-mode cluster \
--driver-memory 6g \
--executor-memory 15g \
--executor-cores 1 \
--num-executors 25 \
--files file1,file2 \
--conf spark.hadoop.fs.s3.awsAccessKeyId=${ACC_KEY} \
--conf spark.hadoop.fs.s3.awsSecretAccessKey=${SEC_KEY} \
--conf spark.hadoop.fs.s3a.awsAccessKeyId=${ACC_KEY} \
--conf spark.hadoop.fs.s3a.awsSecretAccessKey=${SEC_KEY} \
--conf spark.hadoop.fs.s3n.awsAccessKeyId=${ACC_KEY} \
--conf spark.hadoop.fs.s3n.awsSecretAccessKey=${SEC_KEY} \
--class FCQN \
yourJar.jar \
--arg1 val1 \
--garg2 val2 \
--arg3 val3