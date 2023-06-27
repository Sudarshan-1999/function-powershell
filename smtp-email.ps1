$smtpServer = "smtp.office365.com"
$smtpPort = 587 

$smtpUsername = "sudarshan.damahe@*****.com"
$smtpPassword = Read-host "Enter Password " -AsSecureString
$emailParams = @{
    From       = "sudarshan.damahe@*****.com"
    To         = "vamshi.allanki@*****.com"
    Subject    = "This is Test Email"
    Body       = "Hi !!! Vamshi"
    # SmtpServer = $smtpServer
    SmtpServer = $smtpServer
    Port       = $smtpPort
    UseSsl     = $true  # Enable SSL/TLS encryption
    Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $smtpUsername, ($smtpPassword)
}
Send-MailMessage @emailParams