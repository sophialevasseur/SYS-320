Get-Service | Where {$_.Status -eq "Stopped"} | Sort Name | Export-Csv stopped.csv
