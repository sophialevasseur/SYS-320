clear

# Menu of choice options:
$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Show Configuration`n"
$Prompt += "2 - Change Configuration`n"
$Prompt += "3 - Exit`n"

# For Option 1 - Read Configuration Function (configuration should be displayed as pscustomobject): 
function $readConfiguration() {
    $showFirstLine = Get-Content -Path C:\Users\champuser\SYS-320\week7\configuration.txt -First 1
    $showSecondLine = Get-Content -Path C:\Users\champuser\SYS-320\week7\configuration.txt -Second 2
        $display = @ ()
        $display += [pscustomobject]@{"Number of Days" = "$showFirstLine"
                                      "Execution Time" = "$showSecondLine"
                                      }
    
    }
# For Option 2 - Change Configuration Function (This option will ask the user for new configuration and replace the old configuration with new): 
function $changeConfiguration($change) {
    $change = 
    }

$operation = $true

while($operation){

    Write-Host $Prompt | Out-String
    $choice = Read-Host

# Prompt 3 Code: Exit (to exit the menu)
    if($choice -eq 3){
        Write-Host "Goodbye"
        exit
    }

# Prompt 1 Code: Show configuration 
    elseif($choice -eq 1){
        return $display
    }

# Prompt 2 Code: Change Configuration
    elseif($choice -eq 2){
        return $change  
    }
