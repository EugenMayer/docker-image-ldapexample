#!/bin/sh

set -e

if [ -z "$1" ]; then
    echo "please pass the ip as the first parameter"
    exit 1
fi

ip=$1
# Specify where we will install
# the xip.io certificate
SSL_DIR=certs

# Set our CSR variables
SUBJ="
C=DE
ST=Niedersachsen
O=ExampleOrg
localityName=HN
commonName=$ip
organizationalUnitName=IT
emailAddress=info@company.tld
"

# Create our SSL directory
# in case it doesn't exist
sudo rm certs -fr
mkdir -p "$SSL_DIR"

# Generate our Private Key, CSR and Certificate
# consul NEEDS a CA signed certificate, since we can only trust CAs but not certificates, running into
# consul: error getting server health from "consulserver": rpc error getting client: failed to get conn: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "127.0.0.1")
openssl req -nodes -days 1825 -x509 -newkey rsa:2048 -keyout ${SSL_DIR}/ca.key -out ${SSL_DIR}/ca.crt -subj "$(echo -n "$SUBJ" | tr "\n" "/")"
openssl req -nodes -newkey rsa:2048 -keyout ${SSL_DIR}/tls.key -out ${SSL_DIR}/cert.csr -subj "$(echo -n "$SUBJ" | tr "\n" "/")"
openssl x509 -req -days 1825 -in ${SSL_DIR}/cert.csr -CA ${SSL_DIR}/ca.crt -CAkey ${SSL_DIR}/ca.key -CAcreateserial -out ${SSL_DIR}/cert.crt

# this is the user the container runs openldap as
chown 1001:1001 $SSL_DIR/*
chmod 400 $SSL_DIR/tls.key

