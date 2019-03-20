#!/bin/bash

## Set environment paths
echo "export LC_ALL=C.UTF-8" >> ${HOME}/.profile
echo "export LANG=C.UTF-8" >> ${HOME}/.profile

export LC_ALL=C.UTF-8
export LANG=C.UTF-8


### Install NodeJS
cd ~
curl -sL https://deb.nodesource.com/setup_11.x | bash -
apt-get install -y nodejs


## Build and Install Python3.7
apt-get install -y checkinstall
##The following dependencies are sourced from: https://bugs.python.org/issue31652 
apt-get install -y libsqlite3-dev sqlite3 bzip2 libbz2-dev zlib1g-dev libssl-dev openssl libgdbm-dev liblzma-dev libreadline-dev libncursesw5-dev libffi-dev uuid-dev
cd /usr/src
wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz
tar xzf Python-3.7.2.tgz
cd Python-3.7.2
./configure --enable-optimizations
make altinstall


### Install Web3-Gear
python3.7 -m pip install web3-gear

### Create StartUp-Scrip
echo "########################"
echo "Creating Startup Script"
echo "########################"
cd ~
echo "sleep 5" >> ./start-vechain-thor.sh
echo "web3-gear --host 0.0.0.0  > /dev/null 2>&1 &" >> ./start-vechain-thor.sh
