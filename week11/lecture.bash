#! /bin/bash

function pageCount() {
file="/var/log/apache2/access.log"

results=$(cat "$file" | cut -d' ' -f7 | sort -n | uniq -c)

echo "$results"

}

pageCount
