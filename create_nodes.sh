#!/bin/bash

# create 3 node
for i in 1 2 3; do
    docker-machine create -d virtualbox \
    --virtualbox-memory 1024 \
    --virtualbox-disk-size 4096 \
    --virtualbox-hostonly-nicpromisc allow-all \
    node-$i
done
