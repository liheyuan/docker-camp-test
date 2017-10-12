#!/bin/bash

# submit to swarm master node
eval $(docker-machine env node-1)
docker service create \
    --network macvlan --network camp \
    --replicas 3 \
    --name sbmvt-test \
    --hostname="{{.Service.Name}}-{{.Task.Slot}}-test" \
    --entrypoint="sleep 3600" \
    alpine 
