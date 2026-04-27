#! /bin/bash

function pageCount() {
file="/var/log/apache2/access.log"

results=$(cat "$file" | cut -d' ' -f1 | sort -n | uniq -c)

echo "$results"

}

function countingCurlAccess() {

file="/var/log/apache2/access.log"

results=$(grep 'curl/7\.81\.0' "$file" \
         | awk '{print $1, "\"curl/7.81.0\""}' \
         | sort -n \
         | uniq -c
)

echo "$results"

}

countingCurlAccess
