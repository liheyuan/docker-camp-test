# docker-mysql-test

## Build swarm env 
```
# first time
./create_nodes.sh
./init_swarm.sh

# after reboot vm
./start_nodes.sh
./init_swarm.sh
./create_dns.sh

# stop 
./stop_nodes.sh

```

## Start service
```
./create_service_test.sh
```
