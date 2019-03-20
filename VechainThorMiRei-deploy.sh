#!/bin/bash


### Supported OS: Debian 9

## OPTIONAL - activate Swap
## echo "########################"
## echo "Activating Swap"
## echo "########################"
## dd if=/dev/zero of=/mnt/myswap.swap bs=1M count=2000 &&  mkswap /mnt/myswap.swap &&  swapon /mnt/myswap.swap
## echo "/mnt/swap.img    none    swap    sw    0    0" >> /etc/fstab


### Update System and install dependencies
apt-get update
apt-get -y install build-essential libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev git libcap2-bin
apt autoremove -y
apt-get clean

### OPTIONAL - VIM Visual Mode off
## touch ${HOME}/.vimrc && echo "set mouse-=a" >> ${HOME}/.vimrc

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

### Create vechain-thor user
useradd -m -d /home/thor-node -s /bin/bash thor-node
su - thor-node

## Set environment paths
cd ~
touch ${HOME}/.profile
echo "export PATH=$PATH:/usr/local/go/bin" >> ${HOME}/.profile
echo "export GOPATH=$HOME/go" >> ${HOME}/.profile

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
mkdir -p $GOPATH/src
source .profile

### OPTIONAL - VIM Visual Mode off
## touch ${HOME}/.vimrc && echo "set mouse-=a" >> ${HOME}/.vimrc


### Install VeChain
echo "########################"
echo "Installing VeChain"
echo "########################"
git clone https://github.com/mirei83/thor.git $GOPATH/src/VeChain/thor
cd $GOPATH/src/VeChain/thor
make dep
make all

### Get Custom Chain config
wget https://raw.githubusercontent.com/mirei83/vechain-customnet/master/MiRei.json -O  /home/thor-node/go/src/VeChain/thor/genesis/MiRei.json

### exit user 
#exit

### OPTIONAL - Run Vechain Thor API on lower ports like HTTP (80)
#setcap 'cap_net_bind_service=+ep' /home/thor-node/go/src/VeChain/thor/bin/thor
