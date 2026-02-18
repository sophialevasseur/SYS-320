function Get-CourseTable {
    param(
        [string]$Path = 'C:\xampp\htdocs\Courses2026SP.html'
    )

    # Load HTML like a web page
    $page = Invoke-WebRequest -Uri $Path

    # Get all the tr elements of the HTML doc
    $trs  = $page.ParsedHtml.getElementsByTagName('tr')

    # Empty array to hold results
    $fullTable = @()

    # Start at 1 to skip header row if row 0 is headers
    for ($i = 1; $i -lt $trs.length; $i++) {

        # All td cells in this row
        $tds = $trs.item($i).getElementsByTagName('td')

        # Skip empty rows
        if ($tds.length -lt 7) { continue }

        # Split the combined time cell 
        $times = $tds.item(5).innerText -split '-'

        $fullTable += [pscustomobject]@{
            ClassCode = $tds.item(0).innerText.Trim()
            Title     = $tds.item(1).innerText.Trim()
            Days      = $tds.item(4).innerText.Trim()
            TimeStart = $times[0].Trim()
            TimeEnd   = $times[1].Trim()
            Instructor= $tds.item(6).innerText.Trim()
            Location  = $tds.item(7).innerText.Trim()
        }
    }

    return $fullTable
}
