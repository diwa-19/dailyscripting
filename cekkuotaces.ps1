############################
# CEK KUOTA EMAIL CES NOC  #
############################

Try{
#SMTP server configuration
$emailSmtpServer = "smtp.gmail.com"
$emailSmtpServerPort = "587"
$emailSmtpUser = "your gmail acc address"
$emailSmtpPass = "your gmail acc pass"
 
#Sender & recipient
$emailFrom = "your email address"
$emailTo = "your dest email address"
$emailCc = "yout cc email address"

#SMTP client configurarion
$SMTPClient = New-Object System.Net.Mail.SmtpClient( $emailSmtpServer , $emailSmtpServerPort )
$SMTPClient.EnableSsl = $True
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential( $emailSmtpUser , $emailSmtpPass );
	
#Email content
$emailMessage = New-Object System.Net.Mail.MailMessage( $emailFrom , $emailTo )
$emailMessage.CC.Add($emailCc)
$emailMessage.Subject = "Your Subject"
$emailMessage.IsBodyHtml = $true
$emailMessage.Body = 
#bodymail
"Dear Rekan CES,<br/>
<br/>
Mohon dibantu cek sisa kuota untuk nomor berikut :<br/>
<br/>
Regards,<br/>
Your Name<br/><br/>"+
#signature url
"<p><img src=""#yoursignatureURL""/></p>"

#Send Email
$SMTPClient.Send( $emailMessage )
}
Catch{
    Try{
    $SMTPClient.Send( $emailMessage )
    }Catch{
        Try{
        $SMTPClient.Send( $emailMessage )
        }Catch{
        }
    }
}
Finally{
}

#wait 60 sec smtp send
Start-Sleep -Seconds 60
