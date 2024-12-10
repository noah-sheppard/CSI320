#!/bin/bash

LOG_FILE="$1"
IOC_FILE="$2"
OUTPUT_FILE="report.txt"

if [[ -z "$LOG_FILE" || -z "$IOC_FILE" ]]; then
    echo "Usage: $0 <log_file> <ioc_file>"
    exit 1
fi

> $OUTPUT_FILE

while read -r IOC; do
    grep "$IOC" "$LOG_FILE" | awk '{print $1, $4, $7}' >> $OUTPUT_FILE
done < "$IOC_FILE"

echo "Saved to $OUTPUT_FILE"
