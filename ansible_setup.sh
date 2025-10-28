#!/bin/bash

set -e
line='--------------'

echo "$line Make templates folder"
mkdir -p ansible/roles/cert_renew/templates
chmod -R 755 ansible/roles

echo "$line Change to templates folder"
cd ansible/roles/cert_renew/templates

echo "$line Generate Certificates"
openssl genrsa -out rootCA.key 4096
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1825 \
  -out rootCA.pem -subj "/C=GB/ST=GreaterManchester/L=Manchester/O=Sharpishly/OU=DevOps/CN=SharpishlyRootCA"

echo "$line Done. Certificates stored in ansible/roles/cert_renew/templates/"
