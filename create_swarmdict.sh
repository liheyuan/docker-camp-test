#!/bin/bash

# Manager node
NODE="node-1"
IP=$(docker-machine ip $NODE)

echo  $IP

# submit to swarm master node
eval $(docker-machine env $NODE)
docker run \
  -p8080:8080 \
  --env NODE_SWARM_MANAGER=$NODE \
  --env IP_SWARM_MANAGER=$IP \
  --volume /home/docker/machines:/etc/dsd/machines \
  --detach \
  coder4/swarmdict:1.1

