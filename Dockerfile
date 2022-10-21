FROM alpine:edge

RUN apk update && \
    apk add --no-cache ca-certificates caddy tor wget && \
    wget -qO- https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip | busybox unzip - && \
    chmod +x /xray && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /etc/caddy/ /usr/share/caddy

COPY etc/Caddyfile /etc/caddy/Caddyfile
COPY etc/config.json /etc/config.json

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD /entrypoint.sh
