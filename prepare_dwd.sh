#!/bin/sh
set -e
# MyProxy Group fix
groupadd myproxy
# Certificate fix
cp aims1.llns_chain.pem /etc/pki/ca-trust/source/anchors/aims1.llns_chain.pem
update-ca-trust
# Create backup of trust store
cp /etc/pki/tls/certs/ca-bundle.crt /etc/pki/tls/certs/ca-bundle.crt_bak
# Create httpd key
CERTSPATH=/root/esgf/certs
mkdir -p $CERTSPATH
rm -f $CERTSPATH/httpd.key $CERTSPATH/httpd.cert
openssl req -new -newkey rsa:4096 -days 7300 -nodes -x509 \
    -subj "/C=DE/ST=Hessen/L=Offenbach/O=DWD/OU=TI15/CN=$(hostname -f)" \
    -keyout $CERTSPATH/httpd.key  -out $CERTSPATH/httpd.cert
echo Done!
