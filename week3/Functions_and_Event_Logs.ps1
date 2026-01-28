# Get login and logoff records from Windows Events
Get-EventLog -LogName Security -source Microsoft-Windows-Security-Auditing 

# Get the last 14 days
$loginouts = Get-EventLog -LogName Security -source Microsoft-Windows-Security-Auditing -After (Get-Date) .AddDays (-14)
Get-EventLog -LogName Security -After (Get-Date).AddDays(-14) | Where-Object {$_.EventID -in @(4624, 4634)}
