#!/bin/bash

# This script is to install Docker-CE for CentOS
# https://docs.docker.com/engine/installation/linux/centos/

# Removing old version of docker if exist
yum remove -y docker docker-common container-selinux docker-selinux docker-engine

# Install yum-utils, which provides the yum-config-manager utility:
yum install -y yum-utils

# Add the docker ce repo
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Update yum package index
yum makecache fast

# Install Docker CE
yum -y install docker-ce

# Make Docker auto startup
systemctl enable docker.service

# Start Docker
systemctl start docker
