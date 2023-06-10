FROM ubuntu:latest 

# add your keyname
ARG KEY_NAME <add your keyname>

# add the nickname for your validator on the network
ARG MONIKER <add your moniker>

# add the network id
ARG NETWORK_ID highbury_9624-1

# arbitrary validator metadata
ARG DETAILS <details as string>

# add amount you're delegating
ARG TOKEN_DELEGATION <amount>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\ 
	apt-get install -y apt-utils git git-extras software-properties-common vim \
	wget ca-certificates curl build-essential libssl-dev make openssh-server snap

RUN snap install go --classic

# builds out fury
RUN git clone https://github.com/merlin-network/fury-Testnet
WORKDIR /Fury-Testnet/cmd/fury
RUN go install -tags ledger ./... &&\
    mv $HOME/go/bin/fury /usr/bin/

# generate keys
RUN fury keys add $KEY_NAME
    # fury keys add $KEY_NAME --recover &&\
    # fury keys add $KEY_NAME --ledger 

# initialize node
RUN fury init $MONIKER --chain-id highbury_9624-1

# get genesis file
RUN wget https://github.com/merlin-network/fury-Testnet-v2/raw/main/genesis.json -P $HOME/.fury/config/
RUN sed -i 's/minimum-gas-prices = ""/minimum-gas-prices = "0.0001afury"/g' $HOME/.fury/config/app.toml
RUN wget https://github.com/merlin-network/fury-Testnet-v2/raw/main/Docker/fury.service -P $HOME/systemd/system/

# run fury
WORKDIR /Fury-Testnet/cmd/fury
RUN sudo systemctl daemon-reload &&\
    sudo systemctl enable fury.service &&\
    systemctl start fury && journalctl -u fury -f

ENTRYPOINT ["/bin/bash"]
