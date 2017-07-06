#!/bin/bash

echo "Install SNMP & SNMP Utilities"
sudo yum -y install net-snmp net-snmp-utils

echo "Make SNMP start on server bootup"
sudo systemctl enable snmpd.service