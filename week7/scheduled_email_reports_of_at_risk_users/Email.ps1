function SendAlertEmail($Body){

$From = "sophia.levasseur@mymail.champlain.edu"
$To = "sophia.levasseur@mymail.champlain.edu"
$Subject = "Suspicious Activity"

$Password = "INSERT-YOUR-GENERATED-PASSWORD" | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" `
-port 587 -UseSsl -Credential $Credential

}
