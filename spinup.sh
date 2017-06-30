#!/bin/bash

URL=$1

PDC=$2

Domain=$3

Username=$4

Password=$5

ServerAdmin=$6

# Function to display script usage
function quit {
	echo "Usage: $0 {URL to the init setup script repo} {Name of the PDC} {Domain you wanted to join} {Username to join the domain} {Password} {Name of the server admin group}"
	exit 1
}

# Exist script if not all necessary argument is present
if [ -z "$URL" ] || [ -z "$PDC" ] || [ -z "$Domain" ] || [ -z "$Username" ] || [ -z "$Password" ] || [ -z "$ServerAdmin" ]
then
	quit
fi

workdir="/root/script"

# CD into the working directory

cd $workdir

# Get the startup script from repo
wget $URL

# Unzip it and capture the folder name
mkdir tmpunzip
unzip -d tmpunzip *.zip
foldercreated=$(basename tmpunzip/*)
mv tmpunzip/$foldercreated $foldercreated
rm -rf tmpunzip


# CD into the startup script folder
cd $foldercreated

# make all the script executable
chmod +x *.sh *.exp
chmod +x role/*.sh
chmod +x config/*.sh

# run the script (and pass all the argument)
./initsetup.sh $PDC $Domain $Username $Password $ServerAdmin 

# clean up the .zip file
cd $workdir 
rm *.zip
