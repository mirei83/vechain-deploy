#!/bin/bash
## -----------------------------------------------------------------------------
## VeChain Thor Daemon Script
##
## Enjoy it. Share it. Make it better.
##
## (c) by MiRei - contribute some VET/VTHOR: 0x811a2737cC1D879b2398f1072f262D7499c61964
## ----------------------------------------------------------------------------

OPTIONS=${1?Error: Give Argument start|stop|restart}


## Variables
thor_net="main"
thor_path="$GOPATH/src/VeChain/thor/bin/thor"
api_address="0.0.0.0"
api_port=80
p2p_port=11235
check_intervall=10
check_timeout=5

### Function to monitor Thor
monitor_thor () {
    while true; do
      sleep $check_intervall
      if [ $api_address = "0.0.0.0" ]
        then
          api_check_address="127.0.0.1"
      else
          api_check_address=$api_address
      fi
      get_block=$(curl -m $check_timeout -s -X GET http://$api_check_address:$api_port/blocks/best -H  "accept: application/json")
      
      if [ -z "$get_block" ]
        then
          restart_thor
      fi
    done
}

### Function to start Thor
start_thor () { 
    until $thor_path -network $thor_net --api-addr $api_address:$api_port --p2p-port $p2p_port  > /dev/null 2>&1; do
    logger "Vechain Thor: Vechain Thor Node crashed with exit code 0.  Respawning...."
    sleep 5
    done
}

### Function to restart Thor
restart_thor () {
    thor_pid=$(pidof thor)
    logger "Vechain Thor: Restarting Process $thor_pid"
    echo "Restarting Process $thor_pid"
    if [ -z "$thor_pid" ]
      then
        echo "No Thor Process running."
      else
      kill $thor_pid
      kill -CONT $thor_pid
    fi
    start_thor &
}

### Function to stop Thor
stop_thor () {
    thor_pid=$(pidof thor)
    thorroot_pid=$(ps -o ppid= -C thor)
    PGID=$(ps opgid= "$thorroot_pid")
    if [ -z "$thor_pid" ]  || [ -z "$thorroot_pid" ] 
      then
        echo "No Thor Process running."
      else
        echo "Stopping Thor Node"
        logger "Vechain Thor: Stopping Thor Node"
        kill -- -$PGID
        kill $thor_pid
    fi
}

### Script itself


## Start Thor and monitor it
if [ $OPTIONS == start ]
  then
    logger "Vechain Thor: Starting up VeChain Thor."
    echo "Starting up VeChain Thor."   
    start_thor &
    sleep 2
    monitor_thor &

elif [ $OPTIONS == restart ]
  then
    restart_thor
elif [ $OPTIONS == stop ]
  then
    stop_thor
else 
    echo "Choose a valid option."
fi