#!/bin/bash

# Chenk for valid number of arguments
if [ "$#" -lt "2" ]; then {
cat << EOF
This script takes at least 2 arguments: <name of coin 'bitcoin'> <title of container 'relay'> <number of instances '2'>
Number of instances is optional and defaults to 1.
EOF
    exit 1
    } fi

# Determine the default limit for `i`
if [ "$3" == "" ]; then {
    i=1
    }
else {
    i=$3
    } fi

# Setup now Dockerfile and build
cat config/Dockerblank | sed "s/blockchain/$1/g" > Dockerfile
sed -i "s/\.coin/\.$1/g" Dockerfile
#sed -i "s/coin_vars/$(echo $COIN)_vars/g" Dockerfile

#vi litecoin.conf
docker build -t coinclone/$1:$2 .
wait

# Spawn node instances
n=0
while [ $n -lt $i ]; do {
    docker run -d --name $(echo $1)_$(echo $2)_$n -e COIN=$1 coinclone/$1:$2
    n=$(($n+1))
    } done

#docker logs -f --tail 20 relay_1
#docker run -d --name class_n coinclone/coinname:class
