#!/usr/bin/env bash

for i in 1 2 3 10; do
    eval $(docker-machine env node-$i)
    docker swarm leave --force

    docker-machine stop node-$i
done


