# unbound_container [![Docker Image CI](https://github.com/jsanchez0x/unbound_container/actions/workflows/docker-image.yml/badge.svg)](https://github.com/jsanchez0x/unbound_container/actions/workflows/docker-image.yml) [![Generic badge](https://img.shields.io/badge/Docker-Hub-blue.svg?logo=docker&logoColor=white)](https://hub.docker.com/r/jsanchez0x/unbound_container)
Simple implementation of [unbound](https://www.nlnetlabs.nl/projects/unbound/about/) to work with [Pi-Hole](https://pi-hole.net/). Both in separate Docker containers.

## Prerequisites
If the Pi-hole container is running on a network other than the default. If not, this is not necessary.
- Get the name of the network where the Pi-Hole container is located.
- And set an unused IP of this network.

## Build
```bash
git clone https://github.com/jsanchez0x/unbound_container.git
docker build --rm --tag jsanchez0x/unbound_container:latest unbound_container
```

## Run
```bash
docker run -d \
    --name unbound \
    -p 5335:5335/tcp -p 5335:5335/udp \
    --restart=unless-stopped \
    --cap-add=NET_ADMIN \
    jsanchez0x/unbound_container:latest
```

### With custom network
Assuming that the network name is called *pihole-network* and the IP *172.18.0.4* is not used.
```bash
docker run -d \
    --name unbound \
    -p 5335:5335/tcp -p 5335:5335/udp \
    --net pihole-network --ip 172.18.0.4 \
    --restart=unless-stopped \
    --cap-add=NET_ADMIN \
    jsanchez0x/unbound_container:latest
```

## Maintenance
Re-create every 6 months to update the root servers. Necessary to download updated [dns-root-data](https://packages.debian.org/sid/dns-root-data).
