if (Get-Process chrome -ErrorAction SilentlyContinue) {
    Stop-Process chrome
} else {
    Start-Process chrome "https://www.champlain.edu"
}
