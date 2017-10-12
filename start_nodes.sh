#!/usr/bin/env bash

for i in 1 2 3; do
    docker-machine start node-$i
    docker-machine regenerate-certs -f node-$i
done


