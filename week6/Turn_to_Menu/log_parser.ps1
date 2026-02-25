# For PROMPT 1: Display last 10 apache logs (Apache log parser assignment)

# Load the function from the other file  
. .\main.ps1

# Call your function from a main.ps1 file again, and use a Where-Object query on the results this time to get logs, such that the "Page" value should contain "page2.html" and and "Referrer" value should contain "index.html"
Write-Host "`n=== FILTERED LOGS (10.* IPs + page2.html + index.html referrer) ===" -ForegroundColor Green
$filteredLogs = $allLogs | Where-Object { 
    $_.IP -like "10.*" -and 
    $_.Page -like "*page2.html*" -and 
    $_.Referrer -like "*index.html*" 
}
$filteredLogs | Format-Table IP, Page, Referrer, Status -AutoSize
