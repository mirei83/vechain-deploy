Quick Installscript for VeChain Thor Node
==================

All Tests are done on Vultr. Register if you want to and power up a VPS: https://www.vultr.com/?ref=7097618

This is just a simple installscript for a Vechain Thor Node - mainly for myself. Feel free to fork it or just use sniplets of it. Do not use this for Mainnet Nodes without checking for additional security!



1.)  Install VeChain Thor Node
------------------------
This Script is tested on Debian 10 64bit. You can go to the script step-by-step or just execute this from shell:

```shell
curl -sSL https://raw.githubusercontent.com/mirei83/vechain-deploy/master/VechainThorNode-deploy.sh | bash
```
Now you can start/stop the node with 
```shell
systemctl start vechain-thor-mainnet
systemctl stop vechain-thor-mainnet
```

2.) Make it AutoStart (optional)
------------------------
```shell
systemctl enable vechain-thor-mainnet
```
