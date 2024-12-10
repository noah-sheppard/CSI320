#!/bin/bash

INPUT_FILE="report.txt"
OUTPUT_HTML="report.html"

{
    echo "<html>"
    echo "<head><title>Access logs with IOC indicators:</title></head>"
    echo "<body>"
    echo "<h1>Access logs with IOC indicators:</h1>"
    echo "<table border='1'>"
    echo "<tr><th>IP</th><th>Date/Time</th><th>Page Accessed</th></tr>"

    while IFS= read -r line; do
        line=$(echo "$line" | sed 's/\[//g' | sed 's/\]//g')
        echo "<tr><td>${line// /</td><td>}</td></tr>"
    done < "$INPUT_FILE"

    echo "</table>"
    echo "</body>"
    echo "</html>"
} > "$OUTPUT_HTML"

sudo mv "$OUTPUT_HTML" /var/www/html/

echo "Saved to /var/www/html/report.html"
