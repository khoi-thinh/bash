#!/bin/bash

# Get event logs based on a specific range date

# define output 
outfile="C:\Users\khoi.thinh\bash_scripts\cloudwatch_$(date +%F).log"

# define log group name e.g. "/aws/lambda/condeco-employee-data-file-transfer-lambda-prod-s3hook"
echo "Enter a log group name"
read log_group_name

# Define start and end time range
echo "Enter the start time in yyyy-mm-dd HH:MM:SS format"
read start_time

echo "Enter the end time in yyyy-mm-dd HH:MM:SS format" 
read end_time

# convert to epoch time in milliseconds
start_epoch_time=$(date -d "${start_time}" +%s%3N)
end_epoch_time=$(date -d "${end_time}" +%s%3N)

# Get log events
MSYS_NO_PATHCONV=1 aws logs filter-log-events --log-group-name "$log_group_name" --start-time $start_epoch_time --end-time $end_epoch_time --output text > $outfile
