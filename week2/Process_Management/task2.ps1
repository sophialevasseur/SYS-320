Get-Process | Where {$_.Path -notlike "*system32*"} | Select ProcessName, Id, Path
