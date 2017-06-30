#!/bin/bash

# This script is to install Logstash on CentOS
# https://www.elastic.co/guide/en/elasticsearch/reference/master/rpm.html

# Install Java
yum -y install java

# Download and install the public signing key:
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# Setup the Repo
repofile="/etc/yum.repos.d/elasticsearch.repo"
echo "[logstash-5.x]" >> $repofile
echo "name=Elasticsearch repository for 5.x packages" >> $repofile
echo "baseurl=https://artifacts.elastic.co/packages/5.x/yum" >> $repofile
echo "gpgcheck=1" >> $repofile
echo "gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch" >> $repofile
echo "enabled=1" >> $repofile
echo "autorefresh=1" >> $repofile
echo "type=rpm-md" >> $repofile

# Install logstash
yum -y install logstash

# make logstash start when system boot up
systemctl enable logstash.service