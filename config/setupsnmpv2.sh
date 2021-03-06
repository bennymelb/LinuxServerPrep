#!/bin/bash

community=$1

location=$2

contact=$3


# Function to display script usage
function quit {
        echo "Usage: $0 {community string} {system location} {system contact}"
        exit 1
}


# Exist script if not all necessary argument is present
if [ -z "$community" ] || [ -z "$location" ] || [ -z "$contact" ]
then
        quit
fi

snmpconfig=/etc/snmp/snmpd.conf
# remove the default config file to prevent the default public community string
mv $snmpconfig /etc/snmp/snmpd.conf_ORG

# Config SNMP
echo "" >> $snmpconfig
echo "dontLogTCPWrappersConnects yes" >> $snmpconfig
echo "# Config a ReadOnly user" >> $snmpconfig
echo "com2sec ROUser  default $community" >> $snmpconfig
echo "group MyROGroup v2c       ROUser" >> $snmpconfig
echo "view all    included  .1  80" >> $snmpconfig
echo 'access MyROGroup ""      any       noauth    0      all    none   none' >> $snmpconfig
echo "syslocation $location" >> $snmpconfig
echo "syscontact $contact" >> $snmpconfig

# make snmp start when system boot up
systemctl enable snmpd.service

# Start up SNMP
sudo systemctl restart snmpd

