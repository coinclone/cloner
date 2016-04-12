#!/bin/bash

if [ "$1" == "" ]; then {
    COIN=bitcoin
    }
else {
    COIN=$1
    } fi

clear
cat <<EOF
--------
You can either download the $(echo $COIN) prebuilt container from dockerhub
or you can build it from the 'generator' template folder (perhaps if you
have made modifications).
--------

EOF
echo -n "Would you like to build the image locally from $COIN/generator?
y/N: "

read CHOICE
if [ "${CHOICE,,}" == "y" ] || [ "${CHOICE,,}" == "yes" ]; then {
    cd generator/ && \
    bash setup.sh $COIN && \
    cd ..
    }
else {
    docker pull coinclone/$COIN
    wait
    } fi

# Pull the precompiled clone container, run it and save the result
docker run -it --name $(echo $COIN)_seed coinclone/$COIN $COIN && \
docker commit $(echo $COIN)_seed coinclone/$COIN:node && \
docker rm $(echo $COIN)_seed
