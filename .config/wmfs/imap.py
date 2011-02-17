#!/usr/bin/python2.7 -tt
# Author: Bhavik Shah
# Created: 3/5/09
# Description: Simple script that uses the python imap library
# to retrieve number of messages and unread messages from your 
# imap email account. 

# Script is free. Credit to bhaviksblog.com is appreciated =)

import imaplib, sys

# Username should be your username with '@gmail.com' added
# I think the @gmail.com is required.
# If you're trying it with something other than gmail
# you should make the username the full email address
# example@domain.com
username = '' 
password = '' # your pw
mailbox = 'INBOX' # inbox is default

# only tested with gmail and my university email
# it should work with any imap server
# change mail server and port to match your server's info
mailserver = 'imap.gmail.com'
port = 993

# connect to gmail's server (uses SSL, port 993)
server = imaplib.IMAP4_SSL(mailserver,port)

# gmail uses ssl...if your imap mail server doesn't comment the above
# line and uncomment this one.
# server = imaplib.IMAP4(mailserver,port)

# login with the variables provided up top
server.login(username,password)

# select your mailbox
server.select(mailbox)

# pull info for that mailbox
data = str(server.status(mailbox, '(MESSAGES UNSEEN)'))

# print it all out
tokens = data.split()

# clean up output with str_replace()
output = 'Inbox ('+tokens[5].replace(')\'])','')+')'
sys.stdout.write(output)
# close the mailbox
server.close()

# logout of the server
server.logout()
