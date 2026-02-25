# PROMPT - Creating a menu:  From local user management lab (main.ps1, week6)
$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 apache logs`n"
$Prompt += "2 - Display last 10 failed logins for all users`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start Chrome web browser and navigate it to champlain.edu`n"
$Prompt += "5 - Exit`n"

# PROMPT 1:  From Parsing Apache Logs lab (week 6, 
elseif($choice -eq 2){
function Parse-ApacheLogs {
    # Accept a log file path as input
    param([string]$LogFile)
    
    # Read all lines from the log file into a variable
    $allLines = Get-Content $LogFile
    # Create an empty array to store our parsed objects
    $parsedLogs = @()
    
    # Loop through each line  
    foreach ($line in $allLines) {
         
        $words = $line -split ' '
        
        # Only process if we have enough words (skip broken lines)
        if ($words.Count -ge 10) {
             
            $ip = $words[0]
            $ident = $words[1]
            $user = $words[2]
            $time = $words[3]
            $request = $words[4] + ' ' + $words[5] + ' ' + $words[6]
            $status = $words[7]
            $size = $words[8]
            $referrer = $words[9]
            $agent = $words[10]  
            
            # Extract page from request 
            $page = ($request -split ' ')[1]
            
            # Create one object with named properties
            $oneLog = [PSCustomObject]@{
                IP = $ip
                Ident = $ident
                User = $user
                Timestamp = $time
                Request = $request
                Status = $status
                Size = $size
                Referrer = $referrer
                UserAgent = $agent
                Page = $page
            }
            
            $parsedLogs += $oneLog
        }
    }
    
    return $parsedLogs
}

}


# PROMPT 2:  From local user management lab (main.ps1, week6)
   elseif($choice -eq 2){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

            # Check if the user exists
        if(-not (checkUser $name)){
            Write-Host "No user with that name was found."
        } else {
            # Ask the user how many days back to look instead of hardcoding 90
            $days = Read-Host -Prompt "How many days back would you like to search?"
            $userLogins = getFailedLogins $days
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)

                  # Filter to only users with MORE than 10 failed logins
        $userLogins = $grouped | Where-Object { $_.Count -gt 10 } | Select-Object Name, Count

        if($userLogins){
            Write-Host "Last 10 failed user logins in $days days:"
            Write-Host ($userLogins | Format-Table | Out-String)
        } else {
            Write-Host "No failed logins found in the last $days days."
        }
    }

        }
    }

# PROMPT 3: From local user management lab (main.ps1, week6)
    elseif($choice -eq 3){

        $days = Read-Host -Prompt "How many days back would you like to search?"

        # Get all failed logins for the given time period
        $allFailed = getFailedLogins $days

        # Group the results by username and count how many failed logins each user has
        $grouped = $allFailed | Group-Object -Property User

        # Filter to only users with MORE than 10 failed logins
        $atRisk = $grouped | Where-Object { $_.Count -gt 10 } | Select-Object Name, Count

        if($atRisk){
            Write-Host "`nAt Risk Users (more than 10 failed logins in the last $days days):"
            Write-Host ($atRisk | Format-Table | Out-String)
        } else {
            Write-Host "No at-risk users found in the last $days days."
        }
    }

    else {
        Write-Host "Invalid choice. Please enter a number between 1 and 10."
    }

}


# PROMPT 4: 
elseif($choice -eq 4){
$chrome = Get-Process -Name "chrome" -ErrorAction SilentlyContinue

if ($null -eq $chrome) {
    Start-Process "chrome.exe" "https://www.champlain.edu"
    "Chrome was not running -> started and opened Champlain.edu"
} else {
    Stop-Process -Name "chrome" -Force
    "Chrome was running -> stopped all Chrome processes"
}
}

# Exit PROMPT:

$operation = $true

while($operation){

    Write-Host $Prompt | Out-String
    $choice = Read-Host


    if($choice -eq 5){
        Write-Host "Goodbye"
        exit
    }
