#!/bin/bash

# create 3 node
for i in 1 2 3 10; do
    docker-machine create -d virtualbox \
    --virtualbox-memory 1024 \
    --virtualbox-disk-size 4096 \
    --virtualbox-hostonly-nicpromisc allow-all \
    node-$i
done

# copy certs to node-10
./scp_machine_certs.sh

# docker mirror
for i in 1 2 3 10;do
    docker-machine scp ./daemon.json node-$i:/tmp/
    docker-machine ssh node-$i sudo cp -r /tmp/daemon.json /etc/docker/
done

# stop & start
./stop_nodes.sh
./start_nodes.sh
