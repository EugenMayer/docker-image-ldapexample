#!/bin/bash

set -e

cd tls
echo "You will be asked for sudo to chown the certs to 1001:1001"
sudo ./generate-certs.sh ldap

dc up -d
