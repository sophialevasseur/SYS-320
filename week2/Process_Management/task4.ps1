$chrome = Get-Process -Name "chrome" -ErrorAction SilentlyContinue

if ($null -eq $chrome) {
    Start-Process "chrome.exe" "https://www.champlain.edu"
    "Chrome was not running -> started and opened Champlain.edu"
} else {
    Stop-Process -Name "chrome" -Force
    "Chrome was running -> stopped all Chrome processes"
}
