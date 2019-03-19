Quick Installscript for VeChain Thor Node and Web3-Gear
==================

This is an updated fork of Mirei83's scripts which can be found here: https://github.com/mirei83/vechain-deploy

This is just a simple installscript for a Vechain Thor Node - mainly for myself. Feel free to fork it or just use sniplets of it. 
Do not use this for Mainnet Nodes without checking for additional security!

I now added a script to install the Web3-Gear to query more accounts and contracts on the vechain blockchain.

1.)  Install VeChain Thor Node
------------------------
This Script is tested on Debian 8/9 64bit and Ubuntu 16.04/17.10/18.04 64bit. You can go to the script step-by-step or just execute this from shell:

```shell
curl -sSL https://raw.githubusercontent.com/J-Meyer42/vechain-deploy/master/VechainThorNode-deploy.sh | bash
```

2.) Make it AutoStart (optional)
------------------------
In Debian:
Add the following line bevor "exit 0" in /etc/rc.local
```shell
"/PATH/TO/start-vechain-thor.sh"
```

In Ubuntu:
Add this to your crontab
```shell
"@reboot root $HOME/.profile; $HOME/start-vechain-thor.sh"
```



3.) enable external API access (optional)
------------------------
change "start-vechain-thor.sh" to
```shell
/root/go/src/VeChain/thor/bin/thor -network test --api-addr 0.0.0.0:8669
```

4.) Install Web3-Gear
------------------------
As with the first script, simply execute every single step in "VeChain_Web3_deploy.sh" or just do a:

```shell
curl -sSL https://raw.githubusercontent.com/J-Meyer42/vechain-deploy/master/VeChain_Web3_deploy.sh | bash
```

5a.) Start Node
------------------------
```shell
$GOPATH/src/VeChain/thor/bin/thor -network test
```

5b.) Start Web3-Gear
------------------------
```shell
web3-gear --host 0.0.0.0 
```

5c.) Start Node + Web3-Gear in Background
------------------------
```shell
./start-vechain-thor.sh
```

6.) After that, you can do some queries with curl
------------------------

 VTHOR Total Supply
```shell
curl -X POST  http://YOUR.IP.GOES.HERE:8545 -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","id":1,"method":"eth_call","params":[{"from":"0xa4aDAfAef9Ec07BC4Dc6De146934C7119341eE25","to":"0x0000000000000000000000000000456E65726779","data":"0x18160ddd","value":"0x0","gas":"0x2dc6c0"},"latest"]}' | json_pp
```

VTHOR Burned
```shell
curl -X POST  http://YOUR.IP.GOES.HERE:8545 -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","id":1,"method":"eth_call","params":[{"from":"0xa4aDAfAef9Ec07BC4Dc6De146934C7119341eE25","to":"0x0000000000000000000000000000456E65726779","data":"0xd89135cd","value":"0x0","gas":"0x2dc6c0"},"latest"]}' | json_pp
```

query VTHOR of Binance Addresse
```shell
curl -X POST  http://YOUR.IP.GOES.HERE:8545 -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","id":1,"method":"eth_call","params":[{"from":"0xa4aDAfAef9Ec07BC4Dc6De146934C7119341eE25","to":"0x0000000000000000000000000000456E65726779","data":"0x70a08231000000000000000000000000a4aDAfAef9Ec07BC4Dc6De146934C7119341eE25","value":"0x0","gas":"0x2dc6c0"},"latest"]}' | json_pp
```

