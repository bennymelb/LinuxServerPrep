#!/bin/bash

snmpuser=$1
authpass=$2
encpass=$3
location=$4
contact=$5

# Function to display script usage
function quit {
        echo "Usage: $0 {snmpv3user} {authentication password} {encryption password}} {system location} {system contact}"
        exit 1
}


# Exist script if not all necessary argument is present
if [ -z "$snmpuser" ] || [ -z "$authpass" ] || [ -z "$encpass" ] || [ -z "$location" ] || [ -z "$contact" ]
then
        quit
fi

# Stop SNMP service
sudo systemctl stop snmpd

snmpconfig=/etc/snmp/snmpd.conf
# remove the default config file to prevent the default public community string
mv $snmpconfig /etc/snmp/snmpd.conf_ORG

# Create a new snmp config file with the system location and contact
echo "syslocation $location" >> $snmpconfig
echo "syscontact $contact" >> $snmpconfig
echo "dontLogTCPWrappersConnects yes" >> $snmpconfig

# create a snmp v3 user (it will auto add the user to snmp config)
net-snmp-create-v3-user -ro -A $authpass -a SHA -X $encpass -x AES $snmpuser

# make snmp start when system boot up
systemctl enable snmpd.service

# Start up SNMP
sudo systemctl restart snmpd

