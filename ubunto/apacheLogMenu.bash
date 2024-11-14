#! /bin/bash

logFile="/var/log/apache2/access.log.1"

function displayAllLogs(){
    cat "$logFile"
}

function displayOnlyIPs(){
    cat "$logFile" | cut -d ' ' -f 1 | sort -n | uniq -c
}

function displayOnlyPages() {
    grep -E "GET|POST" "$logFile" | grep -E "\.html|\.php" | awk '{print $7}'
}

function histogram(){

    local visitsPerDay=$(cat "$logFile" | cut -d " " -f 4,1 | tr -d '['  | sort \
                              | uniq)
    # This is for debugging, print here to see what it does to continue:
    # echo "$visitsPerDay"

        :> newtemp.txt  # what :> does is in slides
    echo "$visitsPerDay" | while read -r line;
    do
        local withoutHours=$(echo "$line" | cut -d " " -f 2 \
                                     | cut -d ":" -f 1)
        local IP=$(echo "$line" | cut -d  " " -f 1)
          
        local newLine="$IP $withoutHours"
        echo "$IP $withoutHours" >> newtemp.txt
    done 
    cat "newtemp.txt" | sort -n | uniq -c
}

function frequentVisitors() {
    awk '{print $1}' "$logFile" | sort | uniq -c | sort -nr | head -10
}

function suspiciousVisitors() {
    local iocFile="/home/champuser/Documents/IOC.txt"

    grep -Ff "$iocFile" "$logFile" | awk '{print $1}' | sort -u | wc -l
}


while true; do
    echo "Please select an option:"
    echo "[1] Display all Logs"
    echo "[2] Display only IPs"
    echo "[3] Display only page requests"
    echo "[4] Histogram"
    echo "[5] Display frequent visitors"
    echo "[6] Display suspicious visitors"
    echo "[7] Exit"
    read -p "Select an option: " userInput

    case $userInput in
        1) displayAllLogs ;;
        2) displayOnlyIPs ;;
        3) displayOnlyPages ;;
        4) histogram ;;
        5) frequentVisitors ;;
        6) suspiciousVisitors ;;
        7) echo "Goodbye"; exit ;;
        *) echo "Invalid option!" ;;
    esac
done
