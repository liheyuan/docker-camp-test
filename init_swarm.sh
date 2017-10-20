#!/bin/bash

# Leave all swarm nodes
for i in 1 2 3;do
    eval $(docker-machine env node-$i)
    docker swarm leave --force
    docker network rm macvlan
    docker network rm mv-config
done

# Const
SWARM_MANAGER_NODE="node-1"
SWARM_MANAGER_IP=$(docker-machine ip $SWARM_MANAGER_NODE)

# Set node-1 as manager
eval $(docker-machine env $SWARM_MANAGER_NODE)
docker swarm init \
    --advertise-addr $(docker-machine ip $SWARM_MANAGER_NODE)

# Get token
SWARM_MANAGER_TOKEN=$(docker swarm join-token -q manager)
SWARM_WORKER_TOKEN=$(docker swarm join-token -q worker)

# Join other 2 node
for i in 2 3;do
    eval $(docker-machine env node-$i)
    SWARM_TOKEN=""
    if [ $i -eq 2 ];then
        SWARM_TOKEN=$SWARM_MANAGER_TOKEN
    else
        SWARM_TOKEN=$SWARM_WORKER_TOKEN
    fi
    docker swarm join \
        --token $SWARM_TOKEN \
        --advertise-addr $(docker-machine ip node-$i) \
        $SWARM_MANAGER_IP:2377
done

echo ">> The swarm cluster is up and running"

# macvlan network
ETH="eth1"
SUBNET_RANGE="192.168.99.0/24"
IP_RANGES=(EMPTY 192.168.99.128/28 192.168.99.144/28 192.168.99.160/28)
GATEWAY="192.168.99.1"

for i in 1 2 3;do
    IP_RANGE=${IP_RANGES[$i]}
    docker-machine ssh node-$i "sudo ip link set dev $ETH promisc on"
    eval $(docker-machine env node-$i)
    docker network rm mv-config
    docker network create --config-only --subnet $SUBNET_RANGE --gateway $GATEWAY -o parent=eth1 --ip-range $IP_RANGE mv-config
done

eval $(docker-machine env $SWARM_MANAGER_NODE)
docker network remove macvlan
docker network create -d macvlan --scope swarm --config-from mv-config macvlan

# overlay network
eval $(docker-machine env $SWARM_MANAGER_NODE)
docker network remove camp
docker network create --driver overlay camp 
