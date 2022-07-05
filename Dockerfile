FROM debian:stable-slim

LABEL maintainer="Jorge Sánchez <hola@jsanchez.me>"


# Install basic utils
RUN apt-get update && apt-get install --no-install-recommends -y \
    unbound && \
    apt-get clean && \
    rm -rf \
        /tmp/* \
        /var/tmp/* \
        /var/lib/apt/lists/*
    
COPY ./pi-hole.conf /etc/unbound/unbound.conf.d/pi-hole.conf

HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 CMD drill @127.0.0.1 cloudflare.com || exit 1

EXEC unbound -d -c /etc/unbound/unbound.conf.d/pi-hole.conf