#!/bin/bash

#Check if the script is being run as root, as it needs admin permissions
if [[ $(id -u) -ne 0 ]]; then
	echo "This script must be run as root."
	exit 1
fi

#Take the username as input, make sure their home dir exists
read -p "Input username: " USER
homedir=$(getent passwd "$USER" | cut -d: -f6)
if [[ ! -d "$homedir" ]]; then
	echo "User home directory not found"
	exit 2
fi

perm_to_octal() {
local perm=$1
#use the printf command to convert the decimal value to octal string
printf "%o" "$perm"
}

perm_to_rwx() {
local perm=$1

[[ $perm -ge 4 ]] && echo -n 'r' || echo -n '-'
[[ $perm -ge 2 ]] && echo -n 'w' || echo -n '-'
[[ $perm -ge 1 ]] && echo -n 'x' || echo -n '-'
}

#Search the user's home directory recursively and print file info

printf "%-30s %-11s %-14s %-21s %s\n" "File or directory" "Type" "Permission" "Permission/Octal" "Note"

while IFS= read -r -d '' file; do
	perm=$(stat -c "%a" "$file") #get permission as integer
	type=$(if [ -d "$file" ]; then echo "Directory"; else echo "File"; fi) #Check if file is a directory or not
	rwx=$(perm_to_rwx ${perm: -1})$(perm_to_rwx ${perm: -2:1})$(perm_to_rwx ${perm: -3:1}) #Convert perm integer to rwx string
	octal=$(perm_to_octal "$perm") #Convert perm integer to octal string 
	
	# Check if the file has SUID or SGID set
	if [[ $(stat -c "%A" "$file") =~ ^..[sS]. ]]; then
		note="*suspicious"
	else
		note="-"
	fi
	
	printf "%-30s %-11s %-14s %-21s %s\n" "$file" "$type" "$rwx" "$octal" "$note"
done < <(find "$homedir" -print0)
