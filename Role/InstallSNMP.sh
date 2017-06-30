#!/bin/bash

echo "Install SNMP & SNMP Utilities"
yum -y install net-snmp net-snmp-utils

echo "Make SNMP start on server bootup"
chkconfig snmpd on
