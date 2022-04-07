#Make sure you have these modules downloade (may already be downloaded)
import imaplib
import email

# Make sure that this information is correct for you system.
host = 'imap.gmail.com'	#This stays the same unless you are not using gmail
username = 'email address'	#This will need to be the email address that you plan to send and receive with.
												#I've set it up so that the spinners send emails using this email address and they also send it to this email address.
password = 'app specific password'	#This is the app specific password. You need to get this from you gmail account. It will require a little setting up.


def get_inbox(the_subject):
	mail = imaplib.IMAP4_SSL(host)
	mail.login(username, password)
	mail.select("inbox")

	#Be careful about changing search parameters. I found this to work the best.
	#It's going to search for 1,2,3..., or 8 (number of spinners) in the subject line.
	#The underscore here takes the place of a variable. Makes it so that I won't get anything for it, but can still unpack the tuple
	_, search_data = mail.search(None, 'FROM', username, 'UNSEEN', 'SUBJECT', the_subject)
	
	my_message = []	#Declare this variable before starting the loop

	#Run through this loop for every email message that was found in the search.
	#Be careful about changing anything in this part.
	for num in search_data[0].split():
		email_data = {}
		_, data = mail.fetch(num, '(RFC822)')
		_, b = data[0]
		email_message = email.message_from_bytes(b)
		for header in ['subject', 'to', 'from', 'date']:
			email_data[header] = email_message[header]
		for part in email_message.walk():
			#Set up to get both text and html
			if part.get_content_type() == "text/plain":
				body = part.get_payload(decode=True)
				email_data['body'] = body.decode()
			elif part.get_content_type() == "text/html":
				html_body = part.get_payload(decode=True)
				email_data['body'] = html_body.decode()
		my_message.append(email_data)	#Append it to the end of the my_message variable
	return my_message	#Returns all the messages