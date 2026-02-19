$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.37/Courses2026SP.html

$rows = $page.ParsedHtml.body.getElementsByTagName("tr")

$FullTable = @()
For($i=1; i -lt $rows.length; $i++){
    $coloumns = $rows[$i].getElementsByTagName("td")
}

$FullTable = Get-Object 
