# unbound_container
Recursive DNS container

## Prerequisites
- Get the name of the network where the Pi-Hole container is located (for example pihole-network). 
- And set an unused IP of this network (for example 172.18.0.4).

## Build
```bash
docker build --rm --tag jsanchez0x/unbound:local .
```

## Run
```bash
docker run -d \
    --name unbound \
    -p 5335:5335/tcp -p 5335:5335/udp \
    --net pihole-network --ip 172.18.0.4 \
    --restart=unless-stopped \
    jsanchez0x/unbound:local
```

## Maintenance
Re-create every 6 months to update the root servers. Necessary to download updated [dns-root-data](https://packages.debian.org/sid/dns-root-data).