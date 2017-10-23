#!/usr/bin/env bash

for i in 1 2 3 10; do
    docker-machine rm node-$i
done


