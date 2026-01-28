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


# Create another function to obtain computer start and shut-down times
function Get-StartupShutdownEvents {
    param(
        [int]$Days = 14
    )
    
    # Get startup and shutdown records from Windows System Events
    # EventID 6005 or 6009 = Startup, EventID 6006 = Shutdown
    $events = Get-EventLog -LogName System -After (Get-Date).AddDays(-$Days) | Where-Object {$_.EventID -in @(6005, 6006, 6009)}
    
    # Create an empty array to store custom objects
    $eventsTable = @()
    
    # Loop through each event
    for($i=0; $i -lt $events.Count; $i++){
        
        # Determine whether it is a startup or shutdown
        $event = ""
        if($events[$i].EventId -eq 6005) {$event="Startup"}
        if($events[$i].EventId -eq 6009) {$event="Startup"}
        if($events[$i].EventId -eq 6006) {$event="Shutdown"}
        
        # User is always "System" for these events
        $user = "System"
        
        # Add 4 properties to the array
        $eventsTable += [PSCustomObject]@{
            "Time" = $events[$i].TimeGenerated
            "Id" = $events[$i].EventId
            "Event" = $event
            "User" = $user
        }
    }
    
    # Return the table
    return $eventsTable
}
