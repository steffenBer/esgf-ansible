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
CERTHOSTNAME=$(hostname -f)
mkdir -p $CERTSPATH
rm -f $CERTSPATH/$CERTHOSTNAME.key $CERTSPATH/$CERTHOSTNAME.cert
openssl req -new -newkey rsa:4096 -days 7300 -nodes -x509 \
    -subj "/C=DE/ST=Hessen/L=Offenbach/O=DWD/OU=TI15/CN=$CERTHOSTNAME" \
    -keyout $CERTSPATH/$CERTHOSTNAME.pem  -out $CERTSPATH/$CERTHOSTNAME.cert
cat $CERTSPATH/$CERTHOSTNAME.cert $CERTSPATH/$CERTHOSTNAME.cert > $CERTSPATH/${CERTHOSTNAME}_chain.cert
echo Done!
