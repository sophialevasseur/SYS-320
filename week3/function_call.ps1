# Load functions from Event-Logs.ps1 using dot sourcing
. (Join-Path $PSScriptRoot "Functions_and_Event_Logs.ps1")

# Clear the screen
clear

# Get Login and Logoffs from the last 15 days
$loginoutsTable = Get-LoginLogoffEvents -Days 15
$loginoutsTable

# Get Shut Downs from the last 25 days
$shutdownsTable = Get-StartupShutdownEvents -Days 25 | Where-Object {$_.Event -eq "Shutdown"}
$shutdownsTable

# Get Start Ups from the last 25 days
$startupsTable = Get-StartupShutdownEvents -Days 25 | Where-Object {$_.Event -eq "Startup"}
$startupsTable
