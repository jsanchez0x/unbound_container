FROM debian:stable-slim

LABEL maintainer="Jorge Sánchez <hola@jsanchez.me>"

RUN apt-get update && apt-get -y upgrade && apt-get install --no-install-recommends -y \
    dns-root-data \
    ldnsutils \
    unbound && \
    apt-get clean && \
    rm -rf \
        /tmp/* \
        /var/tmp/* \
        /var/lib/apt/lists/*

# Pi-Hole configurations
COPY ./pi-hole.conf /etc/unbound/unbound.conf.d/pi-hole.conf

# Added correct anchor configuration
RUN rm /etc/unbound/unbound.conf.d/root-auto-trust-anchor-file.conf
COPY ./root-auto-trust-anchor-file.conf /etc/unbound/root-auto-trust-anchor-file.conf

HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 CMD drill @127.0.0.1 cloudflare.com -p 5335 || exit 1

ENTRYPOINT  ["unbound", "-d", "-vvvv"]
