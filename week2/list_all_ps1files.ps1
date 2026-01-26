# List all the files in your working directory that have the extension ".ps1"
$files = Get-ChildItem 
for ($j=0; $j -le $files.Count; $j++){
    if ($files[$j].extension -ilike ".ps1"){
        Write-Host $files[$j].Name
    }
}
