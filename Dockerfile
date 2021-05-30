FROM ubuntu:20.04
#COPY ./cnbcoin.conf /root/.cnbcoin/cnbcoin.conf
COPY . /cnbcoin
WORKDIR /cnbcoin

#shared libraries and dependencies
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Pacific/Auckland
RUN apt update && \
    apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev software-properties-common
#RUN apt-get update && apt-get install -y libdb-dev libdb++-dev libminiupnpc-dev libzmq3-dev

#build cnbcoin source
RUN ./autogen.sh
RUN ./configure --disable-wallet
RUN make
RUN make install

#open service port
EXPOSE 9666 19666
CMD ["cnbcoind", "--printtoconsole"