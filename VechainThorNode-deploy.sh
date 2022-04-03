#!/bin/bash

### Supported OS: Debian 10

### Update System and install dependencies
apt-get update
apt-get -y install build-essential libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev git libcap2-bin
apt autoremove -y
apt-get clean

### OPTIONAL - VIM Visual Mode off
## touch ${HOME}/.vimrc && echo "set mouse-=a" >> ${HOME}/.vimrc

### Increase open file limit for all users
echo 'thor-node soft nproc 16384' >> /etc/security/limits.conf 
echo 'thor-node hard nproc 16384' >> /etc/security/limits.conf 
echo 'thor-node soft nofile 16384' >> /etc/security/limits.conf  
echo 'thor-node hard nofile 16384' >> /etc/security/limits.conf 

#echo "session required /lib/security/pam_limits.so" >> /etc/pam.d/login

### Install go
echo "########################"
echo "Installing go"
echo "########################"
cd ~
wget https://golang.org/dl/go1.18.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.18.linux-amd64.tar.gz
chmod +x /usr/local/go/bin/go
rm go1.18.linux-amd64.tar.gz

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
#touch ${HOME}/.vimrc && echo "set mouse-=a" >> ${HOME}/.vimrc


### Install VeChain
echo "########################"
echo "Installing VeChain"
echo "########################"
git clone https://github.com/vechain/thor.git $GOPATH/src/VeChain/thor
cd $GOPATH/src/VeChain/thor
make dep
make all

exit


### Create StartUp autostart
echo "########################"
echo "Creating Mainnet-Startup Script"
echo "########################"
cat <<EOF >/etc/systemd/system/vechain-thor-mainnet.service
# Contents of /etc/systemd/system/vechain-thor-mainnet.service
[Unit]
Description=VeChain Thor Mainnet Node
After=network.targe

[Service]
Type=simple
Restart=always
User=thor-node
Group=thor-node
WorkingDirectory=/home/thor-node/
LimitNOFILE=16384
ExecStart=/home/thor-node/go/src/VeChain/thor/bin/thor -network main --api-addr 0.0.0.0:8669 --p2p-port 11235 --data-dir /home/thor-node/.org.vechain.thor

[Install]
WantedBy=multi-user.target
EOF
chmod +x /etc/systemd/system/vechain-thor-mainnet.service
systemctl daemon-reload
systemctl start vechain-thor-mainnet
