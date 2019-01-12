# cloner
Spawn and distribute blockchain networks on the fly.

debian, jessie

## Dependencies
[git](https://git-scm.com/downloads "git client"), [docker](https://docs.docker.com/engine/installation/ "docker engine")

## Instructions
Clone the repo and run the setup script.

    git clone https://github.com/coinclone/cloner.git && \
    cd cloner && \
    bash setup.sh <blockchain> 

Once the genesis blocks have been mined you will find a new image inside your local repository named `coinclone/<blockchain>:node`. This is the base image for your nodes.

Move into `cloner/deploy/`, edit the `config/coin.conf` file to your specifications and build any class of container you want (miner, relay).

    cd deploy/

    #vi config/coin.conf
    bash setup.sh <blockchain> <node_class> <number_of_instances>

You do not need to configure the `rpcpassword` option in `config/coin.conf`. It will be automatically appended at runtime.

Run at least two instances to establish a network. You may deploy as many instances as you wish.

    bash setup.sh bitcoin miner 1 && \
    sed -i 's/gen=1/gen=0/g' config/coin.conf && \
    bash setup.sh bitcoin relay 1

![Example](http://s15.postimg.org/aaw1df6u3/network_ss.png)

## Important
IP addresses are deterministic in docker and so each new instance is set to connect to its own IP address - 1. If it fails to receive a response it will connect to its own IP address + 1.

You can add IP addresses manually in `deploy/config/coin.conf`

## Donate
If you like the project and would like to donate some of your time and expertise by contributing to the code base, that would be fantastic and very much appreciated.

If you cannot produce code but would still like to contrubute, you can donate crypto to any of the addresses listed below which is also very much appreciated.

Bitcoin - [13QZpiYuf1ztkWgg1PKLyipM9T5HrDsWAc](https://blockchain.info/address/13QZpiYuf1ztkWgg1PKLyipM9T5HrDsWAc "view address")  
