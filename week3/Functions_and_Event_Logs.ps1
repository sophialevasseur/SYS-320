# DELIVERABLE 1 (Lines 2-3): 
# Get login and logoff records from Windows Events
Get-EventLog -LogName Security -source Microsoft-Windows-Security-Auditing 

# DELIVERABLE 2 (Lines 6-34):
# Get the last 14 days
Get-EventLog -LogName Security -After (Get-Date).AddDays(-14) | Where-Object {$_.EventID -in @(4624, 4634)}

# Create an empty array to store custom objects
# The @() creates an empty table we can add objects to
$loginoutsTable = @()

# Loop through each event
# This table loops from 0 to the total number of events
for($i=0; $i -lt $loginouts.Count; $i++){
   
}

# Determine whether it is a logon or logoff value
  $event = ""
  if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
  if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}
  
# Extract the username from the string
  $user = $loginouts[$i].ReplacementStrings[1]

# Add 4 properties to the array
  $loginoutsTable += [PSCustomObject]@{
    "Time" = $loginouts[$i].TimeGenerated
    "Id" = $loginouts[$i].InstanceId  
    "Event" = $event
    "User" = $user
  }
}
