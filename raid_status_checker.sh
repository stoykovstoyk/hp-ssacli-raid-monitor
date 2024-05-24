#!/bin/bash

# Run ssacli to check the status of all physical drives
OUTPUT=$(ssacli ctrl slot=0 pd all show status)

# Remove "\012" characters from the output
CLEAN_OUTPUT=$(echo "$OUTPUT" | tr -d '\012')

# Initialize a flag to indicate if there's any issue
ISSUE_FOUND=0

# Read each line of the output separately
while IFS= read -r line; do
    # Check if the line ends with "OK"
    if [[ ! $line =~ OK$ ]]; then
        ISSUE_FOUND=1
        break
    fi
done <<< "$CLEAN_OUTPUT"

# Log appropriate message based on the check
if [[ $ISSUE_FOUND -eq 1 ]]; then
    logger -t RAID_STATUS "RAID Alert: Drive issue detected - $CLEAN_OUTPUT"
else
    logger -t RAID_STATUS "RAID Status: All drives are OK"
fi
