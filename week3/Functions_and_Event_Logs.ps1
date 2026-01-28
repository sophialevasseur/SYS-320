# Get login and logoff records from Windows Events
Get-EventLog -system -source Microsoft-Windows-WinLogon

# attempt 2: 
Get-EventLog -LogName Security -source Microsoft-Windows-Security-Auditing 
