#! /bin/bash

# Link to scrape
link="10.0.17.6/IOC.html"

# Retrieve the page with curl
fullPage=$(curl -sL "$link")

# Using XML smartlet to extract table
xmlResults=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select -n --template --copy-of \
"//html//body//table//tr//td[1]")

echo "$xmlResults" | sed -e 's/<td[^>]*>//g' | sed -e 's/<\/td>/;/g' | \
tr ';' '\n' | sed '/^$/d' > IOC.txt

