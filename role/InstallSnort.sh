#!/bin/bash

# Install Pre-requisites packages
yum install -y gcc flex bison zlib zlib-devel libpcap libpcap-devel pcre pcre-devel libdnet libdnet-devel tcpdump epel-release

# Install DAQ
yum install -y https://www.snort.org/downloads/snort/daq-2.0.6-1.f21.x86_64.rpm

# Install Snort 2.9.9
yum install -y https://snort.org/downloads/snort/snort-2.9.9.0-1.centos7.x86_64.rpm

# Setup Pulledpork to auto update Snort rules
yum install -y pulledpork

# Add the path to the rule
echo "include \$RULE_PATH/snort.rules" >> /etc/snort/snort.conf
echo "include \$RULE_PATH/local.rules" >> /etc/snort/snort.conf
echo "include \$RULE_PATH/so_rules.rules" >> /etc/snort/snort.conf

# Search and replace the oinkcode with your own oinkcode so pulledpork can download the rules for registered user 
sed -i 's/|snortrules-snapshot.tar.gz|<oinkcode>/|snortrules-snapshot.tar.gz|{YourOwnOinkcode}/g' /etc/pulledpork/pulledpork.conf

# create the rules directory for pulledpork to store the rule set
mkdir /etc/snort/rules/iplists

# Run pulledpork and update the rules for the first time
pulledpork -c /etc/pulledpork/pulledpork.conf

# Start Snort
service snortd restart