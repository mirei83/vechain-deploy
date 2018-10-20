#!/bin/bash


### Supported OS: Ubuntu 16.04/17.10/18.04 64bit + Debian 8/9

## OPTIONAL - activate Swap
echo "########################"
echo "Activating Swap"
echo "########################"
dd if=/dev/zero of=/mnt/myswap.swap bs=1M count=2000 &&  mkswap /mnt/myswap.swap &&  swapon /mnt/myswap.swap
echo "/mnt/swap.img    none    swap    sw    0    0" >> /etc/fstab

## Set environment paths
cd ~
touch ${HOME}/.profile
echo "export PATH=$PATH:/usr/local/go/bin" >> ${HOME}/.profile
echo "export GOPATH=$HOME/go" >> ${HOME}/.profile
echo "export LC_ALL=C.UTF-8" >> ${HOME}/.profile
echo "export LANG=C.UTF-8" >> ${HOME}/.profile

export LC_ALL=C.UTF-8
export LANG=C.UTF-8
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
mkdir -p $GOPATH/src

### Update System and install dependencies
apt-get update
apt-get -y install build-essential libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev git

### OPTIONAL - VIM Visual Mode off
touch ${HOME}/.vimrc
echo "set mouse-=a" >> ${HOME}/.vimrc

### Install go
echo "########################"
echo "Installing go"
echo "########################"
cd ~
wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz
chmod +x /usr/local/go/bin/go
rm go1.10.3.linux-amd64.tar.gz


### Install dep
echo "########################"
echo "Installing dep"
echo "########################"
cd /usr/local/bin/
wget https://github.com/golang/dep/releases/download/v0.5.0/dep-linux-amd64
ln -s dep-linux-amd64 dep
chmod +x /usr/local/bin/*


### Install VeChain
echo "########################"
echo "Installing VeChain"
echo "########################"
git clone https://github.com/vechain/thor.git $GOPATH/src/VeChain/thor
cd $GOPATH/src/VeChain/thor
make dep
make all

### Install NodeJS
cd ~
curl -sL https://deb.nodesource.com/setup_10.x | bash -
apt-get install -y nodejs

## Install Python3.6
echo "deb http://ftp.de.debian.org/debian testing main" >> /etc/apt/sources.list
echo 'APT::Default-Release "stable";' | tee -a /etc/apt/apt.conf.d/00local
apt-get update
apt-get -t testing install  --yes --force-yes python3.6 python3-pip libssl-dev
update-alternatives --install /usr/bin/python python /usr/bin/python3.6 50

### Install Web3-Gear
pip3 install web3-gear

### Create StartUp-Scrip
echo "########################"
echo "Creating Startup Script"
echo "########################"
cd ~
echo '#!/bin/bash' >> ./vechain-testnet.sh
echo "cd"  >> ./vechain-testnet.sh
echo "$GOPATH/src/VeChain/thor/bin/thor -network test  --api-addr 0.0.0.0:8669 > /dev/null 2>&1 &" >> ./vechain-testnet.sh
echo "sleep 5"  >> ./vechain-testnet.sh
echo "web3-gear --host 0.0.0.0 > /dev/null 2>&1 &" >> ./vechain-testnet.sh
chmod +x ./vechain-testnet.sh

##echo "########################"
##echo "Creating autostart"
##echo "########################"
##echo "${HOME}/vechain-testnet.sh" >> 


## Get  Testnet Coins
curl -X POST -d '{"to":"0x11f14cd4b86b4c105bf118be601b0f9e00137868"}' -H "Content-Type: application/json" https://faucet.outofgas.io/requests

## send transaction
##params: [{
##  "from": "0xb60e8dd61c5d32be8058bb8eb970870f07233155",
##  "to": "0xd46e8dd67c5d32be8058bb8eb970870f07244567",
##  "gas": "0x76c0", // 30400
##  "gasPrice": "0x9184e72a000", // 10000000000000
##  "value": "0x9184e72a", // 2441406250
##  "data": "0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675"
##}]


curl -X POST http://95.179.166.112:8545 -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_sendTransaction","params":[{"from":"0x11f14cd4b86b4c105bf118be601b0f9e00137868","to":"0xd46e8dd67c5d32be8058bb8eb970870f07244567","gas": "0x76c0","gasPrice": "0x9184e72a000","value": "0x9184e72a","data":""}],"id":1}'