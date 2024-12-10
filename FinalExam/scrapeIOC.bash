#!/bin/bash

IOC_URL="http://10.0.17.6/IOC.html"

OUTPUT_FILE="IOC.txt"

curl -s "$IOC_URL" | \
  grep -oP '(?<=<td>)[^<]+(?=</td>)' | \
  awk 'NR % 2 == 1' > "$OUTPUT_FILE" 

echo "Indicators of Compromise saved to $OUTPUT_FILE"
