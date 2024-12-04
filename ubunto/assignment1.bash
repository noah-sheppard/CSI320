#! /bin/bash
clear

# Filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst() {
    echo -n "Please Input an Instructor Full Name: "
    read instName

    echo ""
    echo "Courses of $instName:"
    cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
    sed 's/;/ | /g'
    echo ""
}

function courseCountofInsts() {
    echo ""
    echo "Course-Instructor Distribution"
    cat "$courseFile" | cut -d';' -f7 | \
    grep -v "/" | grep -v "\.\.\." | \
    sort -n | uniq -c | sort -n -r
    echo ""
}

function displayCoursesAtLocation() {
    echo -n "Enter Location: "
    read location
    echo ""
    echo "Courses at $location:"
    cat "$courseFile" | grep "$location" | \
    awk -F';' '{printf "%s | %s | %s | %s | %s\n", $1, $2, $5, $6, $7}'
    echo ""
}



function displayCoursesWithAvailability() {
    echo -n "Enter Course Code: "
    read courseCode
    echo ""
    echo "Available courses for $courseCode:"
    cat "$courseFile" | grep "$courseCode" | awk -F';' '$4 > 0' | \
    sed 's/;/ | /g'
    echo ""
}

while :
do
    echo ""
    echo "Please select an option:"
    echo "[1] Display courses of an instructor"
    echo "[2] Display course count of instructors"
    echo "[3] Display all courses in a given location"
    echo "[4] Display available courses for a given course code"
    echo "[5] Exit"

    read userInput
    echo ""

    if [[ "$userInput" == "5" ]]; then
        echo "Goodbye"
        break

    elif [[ "$userInput" == "1" ]]; then
        displayCoursesofInst

    elif [[ "$userInput" == "2" ]]; then
        courseCountofInsts

    elif [[ "$userInput" == "3" ]]; then
        displayCoursesAtLocation

    elif [[ "$userInput" == "4" ]]; then
        displayCoursesWithAvailability

    else
        echo "Invalid option. Please try again."
    fi
done
