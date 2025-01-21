#!/bin/bash
#Gets the current doctor
currentdoctor=$(whoami)

#sets up the two columns, the doctor's name and indentation
echo "Doctors          Patients"
echo -n "$currentdoctor          "

#iterates through all patients to find doctors affiliated with that file
for file in /opt/WellingtonClinic/patients/*.txt
do
	doctors=$(getent group $(stat -c '%G' $file) | cut -d':' -f4 | tr ',' ' ')
	if [[ "$doctors" == *"$currentdoctor"* ]] 
	then
		name=$(head -n1 $file | tr ',' ' ' | awk '{print $1 " " $2}')
		echo "$name"
		echo -n "                 "
	fi
done

