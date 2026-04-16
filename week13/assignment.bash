#! /bin/bash

# THis is the link that we will scrape
link="10.0.17.6/Assignment.html"

# get the website with curl and tell curl not to give errors
fullPage=$(curl -sL "$link")

tempdata=$(echo "$fullPage" | \
xmlstarlet select --template --value-of \
"//table[@id='temp']//tr//td" | awk 'NR %2 == 1' )

pressuredata=$(echo "$fullPage" | \
xmlstarlet select --template --value-of \
"//table[@id='press']//tr//td" | awk 'NR %2 == 1' )

timedata=$(echo "$fullPage" | \
xmlstarlet select --template --value-of \
"//table[@id='temp']//tr//td[2]")

linecount=$(echo "$tempdata" | wc -l)

# loop by number of lines and print
for (( i=1; i<=$linecount; i++ )); do

	temp=$(echo "$tempdata" | head -n $i | tail -n 1)
	pressure=$(echo "$pressuredata" | head -n $i | tail -n 1)
	times=$(echo "$timedata" | head -n $i | tail -n 1)

	echo -e "$pressure $temp $times"
done
