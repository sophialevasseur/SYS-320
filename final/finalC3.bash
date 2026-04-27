#! /bin/bash

echo "<html>" > report.html
echo "<body>" >> report.html
echo "<h2>Access logs with IOC indicators:</h2>" >> report.html
echo "<table border='1'>" >> report.html

# Reads report.txt and makes the table rows
while read -r line; do

    # separates the line into 3 columns
    IP=$(echo "$line" | awk '{print $1}')
    DATETIME=$(echo "$line" | awk '{print $2}')
    PAGE=$(echo "$line" | awk '{print $3}')

    # Write a table row
    echo "<tr><td>$IP</td><td>$DATETIME</td><td>$PAGE</td></tr>" >> report.html

done < report.txt

# Close the HTML tags
echo "</table>" >> report.html
echo "</body>" >> report.html
echo "</html>" >> report.html

# Move the file to the web server directory
mv report.html /var/www/html/report.html
