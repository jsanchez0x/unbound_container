FROM debian:stable-slim

LABEL maintainer="Jorge Sánchez <hola@jsanchez.me>"

RUN apt-get update && apt-get -y upgrade && apt-get install --no-install-recommends -y \
    ldnsutils \
    unbound && \
    apt-get clean && \
    rm -rf \
        /tmp/* \
        /var/tmp/* \
        /var/lib/apt/lists/*

COPY ./pi-hole.conf /etc/unbound/unbound.conf.d/pi-hole.conf

# This default configuration file prevents unbound from starting without specifying a config file.
RUN rm /etc/unbound/unbound.conf.d/root-auto-trust-anchor-file.conf

HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 CMD drill @127.0.0.1 cloudflare.com -p 5335 || exit 1

ENTRYPOINT  ["unbound", "-d", "-vvvv"]