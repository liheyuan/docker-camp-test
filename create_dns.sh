#!/bin/bash

# submit to swarm master node
eval $(docker-machine env node-1)
docker run -d -p 53:53/udp coder4/rubydns:1.0
