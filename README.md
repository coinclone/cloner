# bitcoinclone
Spawn and distribute blockchain networks on the fly.

debian, jessie  
bitcoin, 0.10  
size, ~440 MB

## Dependencies
[git](https://git-scm.com/downloads "git client"), [docker](https://docs.docker.com/engine/installation/ "docker engine")

## Instructions
Clone the bitcoinclone repo and run the setup script.

    git clone https://github.com/derrend/bitcoinclone.git && \
    cd bitcoinclone && \
    bash setup.sh

Once the genesis blocks have been mined you will find a new image inside your local repository named `derrend/bitcoinclone:node`. This is the base image for your nodes.

Move into `bitcoinclone/deployment_extention/`, edit the `bitcoin.conf` file to your specifications and build any class of container you want (miner, relay).

    cd deployment_extention/

    #vi bitcoin.conf
    docker build -t derrend/bitcoinclone:miner .  # bitcoin.conf, gen=1

    #vi bitcoin.conf
    docker build -t derrend/bitcoinclone:relay .  # bitcoin.conf, gen=0

You do not need to configure the `rpcpassword` option in `bitcoin.conf`. It will be automatically appended at runtime.

Run at least two instances to establish a network. You may deploy as many instances as you wish.

    docker run -d --name miner_1 derrend/bitcoinclone:miner && \
    docker run -d --name relay_1 derrend/bitcoinclone:relay && \
    docker logs -f --tail 20 relay_1

    #docker run -d --name class_n derrend/bitcoinclone:class

![Example](http://s15.postimg.org/aaw1df6u3/network_ss.png)

## Important
IP addresses are deterministic in docker and so each new instance is set to connect to its own IP address - 1. If it fails to receive a response it will connect to its own IP address + 1.

You can add IP addresses manually in `deployment_extention/bitcoin.conf`

## Donate
If you like the project and would like to donate some of your time and expertise by contributing to the code base, that would be fantastic and very much appreciated.

If you cannot produce code but would still like to contrubute, you can donate crypto to any of the addresses listed below which is also very much appreciated.

Bitcoin - [14qQtzyUayEj97JhizmCqwYfovqL6uLtW](https://blockchain.info/address/14qQtzyUayEj97JhizmCqwYfovqL6uLtWj "view address")  
Viacoin - [VbWrkv8aE1zpNWDJsKVT2aGH3nBLrj7pwB](https://chainz.cryptoid.info/via/address.dws?VbWrkv8aE1zpNWDJsKVT2aGH3nBLrj7pwB.htm "view address")
