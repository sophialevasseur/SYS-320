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

lineCount=$(echo "$tempData" | wc -l)

# loop by number of lines and print data accordingly
for (( i=1; i<="$lineCount"; i++ ));
do
	temp=$(echo "$tempData" | head -n $i | tail -n 1)
	pressure=$(echo "$pressureData" | head -n $i | tail -n 1)
	times=$(echo "$timeData" | head -n $i | tail -n 1)

	echo -e "$pressure $temp $times"
done

#linecount=$(echo "$tempdata" | wc -1 )

#for (( sed 's/ / | /g' ));
#do
#	echo "Here is deliverable 1!"

#	temp=$(echo "$tempdata" | head -n $i | tail -n 1 )
#	pressure=$(echo "$pressuredata" | head -n $i | tail -n 1 )
#	times=$(echo "$timedata" | head -n $i | tail -n 1 )

#	echo -e "$temp $pressure $times"

#done
