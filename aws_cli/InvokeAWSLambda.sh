#!/usr/bin/env bash

#When invoking a lambda from the cli, we need to provide a 'payload file' that is basically a JSON analogous to the request class accepted by the Lambda function
#If adding a json string as part of one of the payload elements, make sure you minify the  json.

aws lambda invoke --function-name ${LAMBDA_FUNCTION} --payload file://${payloadFile} lambdaresponse.txt > lambda_ack_file.txt
#Replace the unnecessary quotes placed in the file
sed -i -r 's/\"//g' lambdaresponse.txt

