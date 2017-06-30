#!/bin/bash

# Generate a selfsign cert with the server FQDN

fqdn=$(hostname -A)
hostname=$(hostname)

# Generate a self sign cert
sudo openssl req -subj '/CN=$fqdn/' -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout /etc/pki/tls/private/$hostname.key -out /etc/pki/tls/certs/$hostname.crt
