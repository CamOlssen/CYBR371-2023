#!/bin/bash

echo "Input patient information: "
read -p "First Name: " FIRST
read -p "Last Name: " LAST
read -p "Year of Birth: " YEAR

patient="$FIRST""$LAST""$YEAR".txt
cd /opt/WellingtonClinic/patients

#make sure the patient exists
if [ -f "$patient" ]
then
	echo "Patient record found for $FIRST $LAST."
	#indendation  here is super scuffed, but it does work
	echo "Date of Visit     Attending Doctor     Medication     Dosage"
	while IFS=, read -ra fields; do
		if [ "${fields[0]}" != "$FIRST" ] 
		then
			echo "${fields[1]}""         ""${fields[0]}""              ""${fields[3]}" "${fields[4]}"
		fi
	done < "$patient"
else 
	echo "Patient record not found for $FIRST $LAST"
fi
