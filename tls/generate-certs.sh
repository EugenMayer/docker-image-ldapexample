#!/bin/sh

set -e

DO_CHANGEOWN=${1:-yes}


# Specify where we will install
# the xip.io certificate
SSL_DIR=certs

# Set our CSR variables
SUBJ="
commonName=localhost
C=DE
ST=Niedersachsen
O=ExampleOrg
localityName=HN
organizationalUnitName=IT
emailAddress=info@company.tld
"

# Create our SSL directory
# in case it doesn't exist
if [ $DO_CHANGEOWN == "yes" ]; then
  sudo rm certs -fr
fi
mkdir -p "$SSL_DIR"

openssl req -x509 -newkey rsa:4096 -sha256 -days 1825 -keyout ${SSL_DIR}/tls.key -out ${SSL_DIR}/cert.crt -nodes  -subj "$(echo -n "$SUBJ" | tr "\n" "/")" -addext "subjectAltName=DNS:localhost,DNS:ldap1,DNS:ldap2,IP:127.0.0.1"

# this is the user the container runs openldap as
if [ $DO_CHANGEOWN == "yes" ]; then
  sudo chown 1001:1001 $SSL_DIR/*
  sudo chmod 400 $SSL_DIR/tls.key
fi



