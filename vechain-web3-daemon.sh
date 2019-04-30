#!/bin/bash
## -----------------------------------------------------------------------------
## Web3-Gear Daemon Script
##
## Enjoyit. Share it. Make it better.
##
## (c) by MiRei - contribute some VET/VTHOR: 0x811a2737cC1D879b2398f1072f262D7499c61964
## ----------------------------------------------------------------------------

OPTIONS=${1?Error: Give Argument start|stop|restart}


## Variables
listen_address="0.0.0.0"
listen_port="8545"
endpoint="http://127.0.0.1:80"
check_intervall=10
curl_timeout=5


### Function to monitor Web3
monitor_web3 () {
    while true; do
      sleep $check_intervall
      get_block=$(curl -m $curl_timeout -s -X POST http://$listen_address:$listen_port -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}')
      if [ -z "$get_block" ]
        then
          restart_web3
      fi
    done
}

### Function to start Web3
start_web3 () { 
    until web3-gear --host $listen_address --port $listen_port --endpoint $endpoint  > /dev/null 2>&1; do
    logger "Vechain Web3-Gear: Vechain Web3-Node crashed with exit code 0.  Respawning...."
    sleep 1
    done
}

### Function to restart Web3
restart_web3 () {
    web3_pid=$(pidof -x web3-gear)
    logger "Vechain Web3-Gear: Restarting Process $web3_pid"
    echo "Restarting Process $web3_pid"
    if [ -z "$web3_pid" ]
      then
        echo "No Web3 Process running."
      else
      kill $web3_pid
      kill -CONT $web3_pid
    fi
}

### Function to stop Web3
stop_web3 () {
    ### Find web3 process
    web3_pid=$(pidof -x web3-gear)
    ### get parent PID
    web3root_pid=$(ps -o ppid= -C web3-gear)
    ### get name of daemon script
    PGID=$(ps -p $$ -o comm=)
    
    if [ -z $web3_pid ]  || [ -z $web3root_pid ] 
      then
        echo "No Web3 Process running."
      else
        echo "Stopping Web3 Node"
        logger "Vechain Web3-Gear: Stopping Web3 Node"
        kill $web3_pid > /dev/null 2>&1
        pkill -f  $PGID > /dev/null 2>&1
        
    fi
}

### Script itself


## Start Web3 and monitor it
if [ $OPTIONS == start ]
  then
    logger "Vechain Web3-Gear: Starting up Web3-Gear for VeChain."
    echo "Starting up Web3-Gear for VeChain with PID $$."   
    start_web3 &
    sleep 2
    monitor_web3 &

elif [ $OPTIONS == restart ]
  then
    restart_web3 
elif [ $OPTIONS == stop ]
  then
    stop_web3
else 
    echo "Choose a valid option."
fi