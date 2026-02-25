# Creating a menu: 
$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 apache logs`n"
$Prompt += "2 - Display last 10 failed logins for all users`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start Chrome web browser and navigate it to champlain.edu`n"
$Prompt += "5 - Exit`n"

# Prompt 1: 



# Prompt 2: 



# Prompt 3: 



# Prompt 4: 
$chrome = Get-Process -Name "chrome" -ErrorAction SilentlyContinue

if ($null -eq $chrome) {
    Start-Process "chrome.exe" "https://www.champlain.edu"
    "Chrome was not running -> started and opened Champlain.edu"
} else {
    Stop-Process -Name "chrome" -Force
    "Chrome was running -> stopped all Chrome processes"
}


# Exit Prompt:
