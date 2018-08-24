#!/bin/sh


### Supported OS: Ubuntu 16.04/17.10/18.04 64bit + Debian 8/9

## activate Swap
echo "########################"
echo "Activating Swap"
echo "########################"
dd if=/dev/zero of=/mnt/myswap.swap bs=1M count=2000 &&  mkswap /mnt/myswap.swap &&  swapon /mnt/myswap.swap
echo "/mnt/swap.img    none    swap    sw    0    0" >> /etc/fstab

## Set environment paths
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
mkdir -p $GOPATH/src

### Update System and install dependencies
apt-get update
apt-get -y install build-essential libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev git


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
wget https://github.com/golang/dep/releases/download/v0.3.2/dep-linux-amd64
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

### Create StartUp-Scrip
echo "########################"
echo "Creating Startup Script"
echo "########################"
cd ~
echo '#!/bin/bash' >> ./start-vechain-thor.sh
echo "cd"  >> ./start-vechain-thor.sh
echo "$GOPATH/src/VeChain/thor/bin/thor -network main  > /dev/null 2>&1 &" >> ./start-vechain-thor.sh
chmod +x ./start-vechain-thor.sh


echo "######################################################"
echo "######################################################"
echo "To activate Node on startup on Ubuntu, add this to your crontab"
echo "@reboot root $HOME/.profile; $HOME/start-vechain-thor.sh"
echo "######################################################"


echo "######################################################"
echo "######################################################"
echo "To activate Node on startup on Debian, add the following line bevor "exit 0" in /etc/rc.local"
echo "/PATH/TO/start-vechain-thor.sh"
echo "######################################################"
