class EmailSender {
    [string]$SmtpServer

    EmailSender([string]$smtpServer) {
        $this.SmtpServer = $smtpServer
    }



    [void] SendEmail([string]$from, [string]$to, [string]$subject, [string]$body , [string]$attachment) {
        $smtpUsername = "sudarshan.damahe@rampgroup.com"
        $smtpPassword = read-host "Enter Password " -AsSecureString
        $smtpPort = 587
        $emailParams = @{
            From       = $from
            To         = $to
            Subject    = $subject
            Body       = $body
            Attachment = $attachment
            SmtpServer = $this.SmtpServer
            Port       = $smtpPort
            UseSsl     = $true  # Enable SSL/TLS encryption
            Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $smtpUsername, ($smtpPassword)
        }

        Send-MailMessage @emailParams
    }
}

# Usage example:
$emailSender = [EmailSender]::new("smtp.office365.com")
$emailSender.SendEmail("sudarshan.damahe@rampgroup.com", "vamshi.allanki@rampgroup.com", "BGMI", "I'm Sending BGMI attachment", "c:\Users\SudarshanRamdasDamah\Pictures\New folder\pubg17.jpg")
