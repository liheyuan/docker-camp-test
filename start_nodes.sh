#!/usr/bin/env bash

for i in 1 2 3 10; do
    STATUS=$(docker-machine status node-$i)
    if [ x"$STATUS" == x"Running" ];then
        echo "Already running, skip node-$i"
        continue
    fi
    docker-machine start node-$i
    docker-machine regenerate-certs -f node-$i
done

# scp certs to node-10
./scp_machine_certs.sh
