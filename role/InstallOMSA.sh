#!/bin/bash

# http://linux.dell.com/repo/hardware/latest/
# This script is to install Dell OpenManage Server Admin on Centos

# Setup the Repository
wget -q -O - http://linux.dell.com/repo/hardware/dsu/bootstrap.cgi | bash

# Install DSU (dell system update)
yum -y install dell-system-update

# Install OMSA
yum -y install srvadmin-all