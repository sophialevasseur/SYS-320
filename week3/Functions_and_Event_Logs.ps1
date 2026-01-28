# Get login and logoff records from Windows Events
Get-EventLog -LogName Security -source Microsoft-Windows-Security-Auditing 

# DELIVERABLES:
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

    # Convert SID to username
    try {
        $objSID = New-Object System.Security.Principal.SecurityIdentifier($sid)
        $user = $objSID.Translate([System.Security.Principal.NTAccount]).Value
    } catch {
        $user = $sid
    }
    
# Add 4 properties to the array
  $loginoutsTable += [PSCustomObject]@{
    "Time" = $loginouts[$i].TimeGenerated
    "Id" = $loginouts[$i].InstanceId  
    "Event" = $event
    "User" = $user
  }



# Same code but it is a function: 
function Get-LoginLogoffEvents {
    param(
        [int]$Days = 14
    )
    
    $loginouts = Get-EventLog -LogName Security -After (Get-Date).AddDays(-$Days) | Where-Object {$_.EventID -in @(4624, 4634)}
    
    $loginoutsTable = @()
    
    for($i=0; $i -lt $loginouts.Count; $i++){
        
        $event = ""
        if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
        if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}
        
        $sid = $loginouts[$i].ReplacementStrings[1]
        
        try {
            $objSID = New-Object System.Security.Principal.SecurityIdentifier($sid)
            $user = $objSID.Translate([System.Security.Principal.NTAccount]).Value
        } catch {
            $user = $sid
        }
        
        $loginoutsTable += [PSCustomObject]@{
            "Time" = $loginouts[$i].TimeGenerated
            "Id" = $loginouts[$i].InstanceId
            "Event" = $event
            "User" = $user
        }
    }
    
    return $loginoutsTable
}
