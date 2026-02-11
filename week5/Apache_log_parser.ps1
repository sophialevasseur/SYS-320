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
