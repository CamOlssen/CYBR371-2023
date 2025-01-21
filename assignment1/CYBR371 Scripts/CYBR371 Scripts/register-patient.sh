#!/bin/bash

echo "Input patient information." 
read -p "First Name: " FIRST
read -p "Last Name: " LAST
read -p "Year of Birth: " YEAR
read -p "Phone Number: " PHONE
read -p "Email Address: " EMAIL
read -p "Primary Doctor: " DOC
read -p "Assigned Doctors: " DOCS

cd /opt/WellingtonClinic/patients
sudo touch "$FIRST""$LAST""$YEAR".txt
echo "$FIRST,$LAST,$YEAR,$PHONE,$EMAIL,~$DOC,#$DOCS" | sudo tee "$FIRST""$LAST""$YEAR".txt
sudo chown root "$FIRST""$LAST""$YEAR".txt
#Sets up group for assigned doctors. This is used in searchpatient.sh
sudo groupadd "$FIRST""$LAST""$YEAR""docs"
sudo usermod -a -G "$FIRST""$LAST""$YEAR""docs" $DOC
sudo usermod -a -G "$FIRST""$LAST""$YEAR""docs" $DOCS
sudo chmod 660 "$FIRST""$LAST""$YEAR".txt
sudo chgrp "$FIRST""$LAST""$YEAR""docs" "$FIRST""$LAST""$YEAR".txt
getfacl "$FIRST""$LAST""$YEAR".txt
echo "Patient registered."
