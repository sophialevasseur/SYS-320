#! /bin/bash

echo "To: sophia.levasseur@mymail.champlain.edu" > emailform.txt
echo "Subject: Security Incident" >> emailform.txt
echo "Test" >> emailform.txt
cat emailform.txt | ssmtp sophia.levasseur@mymail.champlain.edu
