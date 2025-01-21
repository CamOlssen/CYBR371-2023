#!/bin/bash

#Check if the script is being run as root, as it needs admin permissions to access the requisite files
if [[ $(id -u) -ne 0 ]]; then
	echo "This script must be run as root."
	exit 1
fi

#Take the username as input, make sure they are a real user
read -p "Input username: " USER
USER_INFO=$(getent passwd "$USER")
if [[ -z "$USER_INFO" ]]; then
	echo "User $USER not found."
	exit 2
fi

#Extract the required information if the user exists
USER_ID=$(echo "$USER_INFO" | cut -d: -f3)
GROUPS=$(id -Gn "$USER" | tr ' ' ',')
GROUP_IDS=$(id -G "$USER" | tr ' ' ',')
HOME_DIR=$(echo "$USER_INFO" | cut -d: -f6)
SHADOW_INFO=$(getent shadow "$USER")
#If the user has a shadow file entry, get relevant data from that
if [[ -n "$SHADOW_INFO" ]]; then
	SHADOW_FILE="Yes"
	HASH=$(echo "$SHADOW_INFO" | cut -d: -f2)
	LAST_CHANGE=$(echo "$SHADOW_INFO" | cut -d: -f3)
	LAST_CHANGE_DATE=$(date -d "@$((LAST_CHANGE * 86400))" +'%d/%m/%Y')
else 
	SHADOW_FILE="No"
	HASH=""
	LAST_CHANGE_DATE=""
fi

#Display the user information 

echo "Username: $USER"
echo "Groups: $GROUPS"
echo "UserID: $USER_ID"
echo "Group(s) ID: $GROUP_IDS"
echo "Home Directory: $HOME_DIR"
echo "Shadow file?: $SHADOW_FILE"
echo "Hash Algorithm used: $HASH"
echo "Date of last password change: $LAST_CHANGE_DATE"

