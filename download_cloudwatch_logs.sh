#!/bin/bash

# log group name e.g. "/aws/lambda/condeco-employee-data-file-transfer-lambda-prod-s3hook"
echo "Enter a log group name"
read log_group_name

# prefix date to filter log streams based on date
echo "Enter the date in yyyy/mm/dd"
read prefix_date

# Fetch all the logs treams starts with prefix date
# When run the script with windows git bash, it automatically append a path to log_group_name and throws an error, MSYS_NO_PATHCONV=1 to disable this behavior

log_streams=$(MSYS_NO_PATHCONV=1 aws logs describe-log-streams --log-group-name "$log_group_name" --log-stream-name-prefix "$prefix_date" --query "logStreams[*].logStreamName" --output text)

# Get log streams and output to text file
for log_stream in $log_streams
do
  echo "Getting log stream $log_stream"
  stream_output=$(echo "$log_stream" | sed 's|/|_|g')
  MSYS_NO_PATHCONV=1 aws logs get-log-events --log-group-name "$log_group_name" --log-stream-name "$log_stream" --output text > "$stream_output.log"
done  
