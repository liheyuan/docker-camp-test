#!/usr/bin/env bash

DST_NODE="node-1"

for i in 1 2 3; do
    docker-machine ssh $DST_NODE mkdir -p /home/docker/machines/node-$i
    docker-machine scp $HOME/.docker/machine/machines/node-$i/cert.pem $DST_NODE:~/machines/node-$i/ 
    docker-machine scp $HOME/.docker/machine/machines/node-$i/key.pem $DST_NODE:~/machines/node-$i/ 
done
