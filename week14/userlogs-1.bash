#! /bin/bash

authfile="/var/log/auth.log"

function getLogins(){
 logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
 dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11 | tr -d '\.')
 echo "$dateAndUser" 
}

function getFailedLogins(){
# Todo - 1
# a) Make a little research and experimentation to complete the function
# b) Generate failed logins and test
  echo "Here are the failed login attempts:"
  failedlogline=$(cat "$authfile" | grep "lightdm" | grep "authentication failure")
  failedDateAndUser=$(echo "$failedlogline" | cut -d' ' -f6 | tr -d '\.')
  echo "$failedDateAndUser"
}

# Sending logins as email - Do not forget to change email address
# to your own email address
echo "To: sophia.levasseur@mymail.champlain.edu" > emailform.txt
echo "Subject: Logins" >> emailform.txt
getLogins >> emailform.txt
cat emailform.txt | ssmtp sophia.levasseur@mymail.champlain.edu

# Todo - 2
# Send failed logins as email to yourself.
# Similar to sending logins as emails.

echo "To: sophia.levasseur@mymail.champlain.edu" > emailform.txt
echo "Subject: Failed Logins" >> emailform.txt
getFailedLogins >> emailform.txt
cat emailform.txt | ssmtp sophia.levasseur@mymail.champlain.edu


