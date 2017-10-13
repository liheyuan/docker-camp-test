#!/bin/bash

# submit to swarm master node
dns_ip=$(docker-machine ip node-1)
eval $(docker-machine env node-1)
docker service create \
    --dns $dns_ip \
    --network macvlan --network camp \
    --replicas 3 \
    --name sbmvt-test \
    --hostname="{{.Service.Name}}-{{.Task.Slot}}-test" \
    --entrypoint="sleep 3600" \
    alpine 
