clear

# For Option 1 - Read Configuration Function (configuration should be displayed as pscustomobject): 
function readConfiguration() {
    $show = Get-Content -Path C:\Users\champuser\SYS-320\week7\configuration.txt 
        $display = @()
        $display += [pscustomobject]@{"Number of Days" = $show[0] 
                                      "Execution Time" = $show[1]
                                      }
        return $display 
    }
# For Option 2 - Change Configuration Function (This option will ask the user for new configuration and replace the old configuration with new): 
function changeConfiguration() {
    
    $days = Read-Host "Enter a number of days:"
    $time = Read-Host "Enter a time: "
    $days | Out-File -FilePath C:\Users\champuser\SYS-320\week7\configuration.txt
    $time | Out-File -FilePath C:\Users\champuser\SYS-320\week7\configuration.txt -Append

    }

# Menu Config Function: 
function configurationMenu{
# Menu of choice options:
$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Show Configuration`n"
$Prompt += "2 - Change Configuration`n"
$Prompt += "3 - Exit`n"
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
        $show = readConfiguration
        Write-Host ($show | Format-Table | Out-String)
    }

# Prompt 2 Code: Change Configuration
    elseif($choice -eq 2){
        changeConfiguration
    }
    }
    }
configurationMenu
