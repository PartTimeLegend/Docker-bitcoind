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
COPY cat.sh /bitcoin/cat.sh

RUN chmod +x /bitcoin/cat.sh
RUN ./cat.sh 

RUN bitcoind -datadir=/bitcoin -rpcbind=0.0.0.0 -rpcallowip=::/0 -conf=/etc/bitcoin.conf
