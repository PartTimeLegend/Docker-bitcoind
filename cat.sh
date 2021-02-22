#!/usr/bin/env bash
cat <<EOF > /etc/bitcoin.conf
datadir=/bitcoin
printtoconsole=1
disablewallet=1
rpcuser=${RPCUSER:-bitcoinrpc}
rpcpassword=${RPCPASSWORD:-`dd if=/dev/urandom bs=33 count=1 2>/dev/null | base64`}
EOF

cat /etc/bitcoin.conf
