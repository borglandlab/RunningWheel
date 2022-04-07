#Make sure that you have these modules downloaded
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart	# multipart allows you to do html emails or to attach files


#Changes these so that they correspond to your email account.
HOST = 'smtp.gmail.com'	#This is for a gmail account
username = 'email address'	#Email address
password = 'app specific password'	#App password. You will need to set this up on your google account first.
from_email = 'Mouse Spinners <email address>'	#Email account that will send the alert email.
to_email = 'personal email'	#Email account that you want to receive the alert. I had it sent to my personal email address so that I'd see it immediately.

def send_wheelalert(wheel):

	#Be careful about changing any of this. The wheel will simply be a number from 1 to 8 (or however many spinners you have)
	msg = MIMEMultipart('alternative')
	msg['From'] = from_email
	msg['To'] = to_email
	msg['Subject'] = 'Alert for Spinner ' + wheel

	text = 'An email from Spinner ' + wheel + ' has not been received.\nCheck power connection to Spinner ' + wheel + '.\nSpinner ' + wheel + ' may have frozen. To unfreeze, unplug the spinner and plug it back in. Be sure to recalibrate when doing this.\nSpinner ' + wheel + ' will not be able to collect data until this problem is fixed.'
	txt_part = MIMEText(text, 'plain')
	msg.attach(txt_part)

	msg_str = msg.as_string()

	#Login to my smtp server
	#Different servers have different hosts and ports
	server = smtplib.SMTP(host=HOST, port=587)	#This is for a gmail account.

	#Make sure the connection is secure
	server.ehlo()
	server.starttls()

	#Login with my username and password
	server.login(username, password)

	#Send the email
	server.sendmail(from_email, to_email, msg_str)

	#Make sure you quit the session
	server.quit()

	#Tells me that the email has been sent.
	print('alert message sent to ' + to_email + ' regarding Spinner ' + wheel)
