#!/bin/bash

# create 3 node
for i in 1 2 3; do
    docker-machine create -d virtualbox \
    --virtualbox-memory 4096 \
    --virtualbox-disk-size 10240 \
    --virtualbox-hostonly-nicpromisc allow-all \
    node-$i
done
