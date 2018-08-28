#!/bin/bash

## Set environment paths
echo "LC_ALL=C.UTF-8" >> ${HOME}/.profile
echo "LANG=C.UTF-8" >> ${HOME}/.profile

export LC_ALL=C.UTF-8
export LANG=C.UTF-8


### Install NodeJS
cd ~
curl -sL https://deb.nodesource.com/setup_10.x | bash -
apt-get install -y nodejs


### Install Web3-Gear
echo "deb http://ftp.de.debian.org/debian testing main" >> /etc/apt/sources.list
echo 'APT::Default-Release "stable";' | tee -a /etc/apt/apt.conf.d/00local
apt-get update
apt-get -y -t testing install python3.6 python3-pip
update-alternatives --install /usr/bin/python python /usr/bin/python3.6 50
pip3 install web3-gear

## VTHOR Total Supply
## curl -X POST  http://95.179.163.6:8545 -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","id":1,"method":"eth_call","params":[{"from":"0x7567d83b7b8d80addcb281a71d54fc7b3364ffed","to":"0x0000000000000000000000000000456E65726779","data":"0x18160ddd","value":"0x0","gas":"0x2dc6c0"},"latest"]}'

## VTHOR Burned
## curl -X POST  http://95.179.163.6:8545 -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","id":1,"method":"eth_call","params":[{"from":"0x7567d83b7b8d80addcb281a71d54fc7b3364ffed","to":"0x0000000000000000000000000000456E65726779","data":"0xd89135cd","value":"0x0","gas":"0x2dc6c0"},"latest"]}'

## VTHOR von Binance Adresse abfragen
## curl -X POST  http://95.179.163.6:8545 -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","id":1,"method":"eth_call","params":[{"from":"0xa4aDAfAef9Ec07BC4Dc6De146934C7119341eE25","to":"0x0000000000000000000000000000456E65726779","data":"0x70a08231000000000000000000000000a4aDAfAef9Ec07BC4Dc6De146934C7119341eE25","value":"0x0","gas":"0x2dc6c0"},"latest"]}'


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