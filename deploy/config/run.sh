#!/bin/bash

#mkdir $HOME/.$COIN/

if [ "$1" == "" ]; then {
    COIN=bitcoin
    }
else {
    COIN="$1"
    } fi

# Capture the suggested rpcpassword paramiter from the uninitialised warning message
$HOME/$COIN/src/$(echo $COIN)d -conf=/root/.$COIN/coin.conf 2> $HOME/credentials.txt || true && \
grep rpcpassword= $HOME/credentials.txt >> $HOME/.$COIN/coin.conf && \
echo "externalip=$(hostname -i)" >> $HOME/.$COIN/coin.conf

# Capture ip components
IP_PT1=$(grep $HOSTNAME /etc/hosts | cut -f 1 | cut -f 1-3 -d .)
IP_PT2=$(expr $(grep $HOSTNAME /etc/hosts | cut -f 1 | cut -f 4 -d .) - 1)
IP_PT3=$(expr $(grep $HOSTNAME /etc/hosts | cut -f 1 | cut -f 4 -d .) + 1)

# Connent forward if no response from lower ip else connect to lower ip
ping -c 1 $IP_PT1.$IP_PT2 > /dev/null
if [ $? -eq 0 ]; then {
    echo "addnode=$IP_PT1.$IP_PT2" >> $HOME/.$COIN/coin.conf
    }
else {
    echo "addnode=$IP_PT1.$IP_PT3" >> $HOME/.$COIN/coin.conf
    } fi

# Start and connect to debug log
$HOME/$COIN/src/$(echo $COIN)d -conf=$HOME/.$COIN/coin.conf &
tail -f $HOME/.$COIN/debug.log
