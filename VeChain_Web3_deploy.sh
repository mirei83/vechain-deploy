#!/bin/bash

## Set environment paths
echo "export LC_ALL=C.UTF-8" >> ${HOME}/.profile
echo "export LANG=C.UTF-8" >> ${HOME}/.profile

export LC_ALL=C.UTF-8
export LANG=C.UTF-8


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
echo "sleep 5" >> ./start-vechain-thor.sh
echo "web3-gear --host 0.0.0.0  > /dev/null 2>&1 &" >> ./start-vechain-thor.sh