#!/bin/sh
set -e
# MyProxy Group fix
groupadd myproxy
# Certificate fix
cp aims1.llns_chain.pem /etc/pki/ca-trust/source/anchors/aims1.llns_chain.pem
update-ca-trust
echo Done!
