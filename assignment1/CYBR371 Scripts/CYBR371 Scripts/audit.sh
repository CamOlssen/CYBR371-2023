#!/bin/bash

sudo apt-get install inotify tools

LOGFILE=/opt/WellingtonClinic/audit.log
cd /opt/WellingtonClinic/
#Create logfile if it does not exist already
if [ ! -f "$LOGFILE" ]
then
	touch "$LOGFILE"
	sudo chown root "$LOGFILE"
	sudo chgrp admins "$LOGFILE"
	sudo chmod 770 "$LOGFILE" 
fi

while true
do
	inotifywait -r -e create,delete,modify /opt/WellingtonClinic
	DATE=$(date)
	echo "$DATE - User $USER - $EVENT" >> "$LOGFILE"
done
	
