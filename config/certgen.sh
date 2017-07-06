#!/bin/bash

# Generate a selfsign cert with the server FQDN

fqdn=$(hostname -A)
hostname=$(hostname)

# trim any whitespace
fqdn=$(echo "$fqdn" | tr -d '[:space:]')

# Generate a self sign cert
openssl req -subj "/CN=$fqdn/" -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout /etc/pki/tls/private/$hostname.key -out /etc/pki/tls/certs/$hostname.crt
