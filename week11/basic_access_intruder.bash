#! /bin/bash
# Create a script that will access your Apache web page 20 times. 
# This function will have a loop that will execute 20 times. 
# In your loop, call curl (curl 10.0.17.26)
# This script is deliverable 2!

{

URL="http://10.0.17.26" 

for i in {1..20} 
do 
         echo "Request $i: Calling $URL"
         curl $URL
done
}
URL
