Quick Installscript for VeChain Thor Node
==================

All Test are done on Vultr. Register if you want and power up a VPS: https://www.vultr.com/?ref=7097618

This is just a simple installscript for a Vechain Thor Node. Do not use this for Mainnet Nodes without checking for additional security!



1.)  Install 
------------------------
This Script is tested on Debian 8/9 64bit and Ubuntu 16.04/17.10/18.04 64bit. Execute this from shell:

```shell
curl -sSL https://raw.githubusercontent.com/mirei83/vechain-deploy/master/VechainThorNode-deploy.sh | bash
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



3.) enable API form outside (optional)
------------------------
change "start-vechain-thor.sh" to
```shell
/root/go/src/VeChain/thor/bin/thor -network main --api-addr 0.0.0.0:8669
```

4a.) Start Node (in Background)
------------------------
```shell
./start-vechain-thor.sh
```

4b.) Start Node
------------------------
```shell
$GOPATH/src/VeChain/thor/bin/thor -network main
```
