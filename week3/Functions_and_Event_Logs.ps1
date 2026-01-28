# Get login and logoff records from Windows Events
Get-EventLog -LogName Security -source Microsoft-Windows-Security-Auditing 

# Get the last 14 days
$loginouts = Get-EventLog -LogName Security -source Microsoft-Windows-Security-Auditing -After (Get-Date) .AddDays (-14)
