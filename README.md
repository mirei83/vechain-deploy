# vechain-deploy

Quick Installscript for VeChain Testnet Node
==================

All Test are done on Vultr. Register if you want and power up a small VPS: https://www.vultr.com/?ref=7097618

This is just a simple installscript to test the Vechain Code. Do not use this for Mainnet Nodes without checking for additional security!



1.)  Install 
------------------------
This Script is tested on Debian 8/9 64bit, Ubuntu 16.04/17.10/18.04 64bit
curl -sSL https://raw.githubusercontent.com/mirei83/vechain-deploy/master/Deploy_Testnet.sh | bash


2.) Start Node
------------------------
./vechain-testnet.sh


3.) Make it AutoStart
------------------------
Add the following line bevor "exit 0" in /etc/rc.local
"/PATH/TO/vechain-testnet.sh"