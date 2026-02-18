# Dot-source the script that contains the function
. "C:\Scripts\Get-ChamplainClasses.ps1"

# Call the function – adjust the name to match your function
$courses = gatherClasses   # or Get-CourseTable

# Print the returned objects in a list layout similar to the example
$courses | Format-List
