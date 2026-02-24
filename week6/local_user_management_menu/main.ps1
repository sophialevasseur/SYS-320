. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List At Risk Users`n"
$Prompt += "10 - Exit`n"


$operation = $true

while($operation){

    Write-Host $Prompt | Out-String
    $choice = Read-Host


    if($choice -eq 10){
        Write-Host "Goodbye"
        exit
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"

        # TODO done: Check if the user already exists
        if(checkUser $name){
            Write-Host "User already exists."
        }
        # TODO done: Check if the password meets the requirements
        elseif(-not (checkPassword $password)){
            Write-Host "Password is not strong enough. It must be at least 6 characters and include a letter, a number, and a special character."
        }
        else{
            # Both checks passed — go ahead and create the user
            createAUser $name $password
            Write-Host "User: $name has been created."
        }
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        # TODO done: Check if the user exists before trying to remove
        if(-not (checkUser $name)){
            Write-Host "No user with that name was found."
        } else {
            removeAUser $name
            Write-Host "User: $name has been removed."
        }
    }


    # Enable a user
    elseif($choice -eq 5){

        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # TODO done: Check if the user exists before trying to enable
        if(-not (checkUser $name)){
            Write-Host "No user with that name was found."
        } else {
            enableAUser $name
            Write-Host "User: $name has been enabled."
        }
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # TODO done: Check if the user exists before trying to disable
        if(-not (checkUser $name)){
            Write-Host "No user with that name was found."
        } else {
            disableAUser $name
            Write-Host "User: $name has been disabled."
        }
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # TODO done: Check if the user exists
        if(-not (checkUser $name)){
            Write-Host "No user with that name was found."
        } else {
            # TODO done: Ask the user how many days back to look instead of hardcoding 90
            $days = Read-Host -Prompt "How many days back would you like to search?"
            $userLogins = getLogInAndOffs $days
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # TODO done: Check if the user exists
        if(-not (checkUser $name)){
            Write-Host "No user with that name was found."
        } else {
            # TODO done: Ask the user how many days back to look instead of hardcoding 90
            $days = Read-Host -Prompt "How many days back would you like to search?"
            $userLogins = getFailedLogins $days
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
    }


    # TODO done: New option - List At Risk Users (more than 10 failed logins)
    elseif($choice -eq 9){

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


    # TODO done: Handle invalid input — if the user types something not on the menu
    else {
        Write-Host "Invalid choice. Please enter a number between 1 and 10."
    }

}
