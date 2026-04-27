#! /bin/bash


cat access.log | cut -d' ' -f1,4,7 | tr -d '[' | \
egrep -i -f IOC.txt > report.txt

# Gathering the 2 log files
#link="https://drive.google.com/file/d/1Ib6XMUQpsMAvyWwNOBMLIChTM29hcy0t/view?pli=1"

#curl -sL "$link" -o access.log

#iocFile=$2

# Creating the report file
#> report.txt

#while read -r IOC; do

#  while read -r LINE; do

 #   IP=$(echo "$LINE" | awk '{print $1}')
  #  dayTime=$(echo "$LINE" | awk '{print $4}' | tr -d '[')
   # page=$(echo "$LINE" | awk '{print $7}')
   # echo "$IP $dayTime $page" >> report.txt

#  done < <(grep "$IOC" access.log)
#done < "$iocFile"

