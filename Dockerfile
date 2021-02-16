FROM alpine

RUN apk update && apk add \
    openssl \
    wget \
    ca-certificates \
    bitcoin \
    bitcoin-cli

RUN mkdir /bitcoin
ENV HOME /bitcoin
VOLUME ["/bitcoin"]
WORKDIR /bitcoin
EXPOSE 8332 8333

RUN echo "printtoconsole=1" >> /etc/bitcoin.conf
RUN echo "datadir=/bitcoin" >> /etc/bitcoin.conf
RUN echo "rpcuser=${RPCUSER:-bitcoinrpc}" >> /etc/bitcoin.conf
RUN echo "rpcpassword=${RPCPASSWORD:-`dd if=/dev/urandom bs=33 count=1 2>/dev/null | base64`}" >> /etc/bitcoin.conf

RUN cat /etc/bitcoin.conf

RUN bitcoind -datadir=/bitcoin -rpcbind=0.0.0.0 -rpcallowip=::/0 -conf=/etc/bitcoin.conf1