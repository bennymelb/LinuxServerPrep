#!/bin/bash

# Declare Variable

PDC=$1

Domain=$2

Username=$3

Password=$4

ServerAdmin=$5

# Function to display script usage
function quit {
	echo "Usage: $0 {Name of the PDC} {Domain you wanted to join} {Username to join the domain} {Password} {Name of the server admin group}"
	exit 1
}


# Exist script if not all necessary argument is present
if [ -z "$PDC" ] || [ -z "$Domain" ] || [ -z "$Username" ] || [ -z "$Password" ] || [ -z "$ServerAdmin" ]
then
	quit
fi


# update the system
yum -y update

# install necessary packages
yum -y install realmd samba samba-common oddjob oddjob-mkhomedir sssd ntpdate ntp expect

# Stop firewall
systemctl stop firewalld

# disable firewall
systemctl disable firewalld

# Make ntp service auto startup 
systemctl enable ntpd.service

# sync system time with PDC
ntpdate $PDC

# Start ntp service
systemctl start ntpd.service

# Join machine to domain (call the expect script)
./JoinDomain.exp $Domain $Username $Password

# Add the default domain suffix to sss config
sed -i "/\[sssd\]/a default_domain_suffix = $Domain" /etc/sssd/sssd.conf
systemctl restart sssd

# Allow member of linuxadmin group in AD to login to this server
realm permit -g $ServerAdmin@$Domain

# Add member of linuxadmin group to sudo
echo "" >> /etc/sudoers
echo "# Allow member of the below AD group to run any commands anywhere" >> /etc/sudoers
echo "%$ServerAdmin@$Domain	ALL=(ALL)	ALL" >> /etc/sudoers
