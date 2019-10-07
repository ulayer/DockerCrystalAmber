FROM debian:stable

RUN apt-get update
RUN apt-get install -y openvpn git netcat ca-certificates inetutils-ping curl wget dnsutils postgresql-client mariadb-client libssl-dev libxml2-dev libyaml-dev libgmp-dev libreadline-dev libz-dev libsqlite3-dev libpq-dev libmariadb-dev pkg-config libpcre3-dev libevent-dev build-essential sudo htop procps
WORKDIR /app
COPY ./scripts/* /app/scripts/
RUN ["/bin/bash", "-c", "/app/scripts/install-crystal.sh"]
WORKDIR /amber
RUN ["/bin/bash", "-c", "/app/scripts/install-amber.sh"]
WORKDIR /app
COPY shard.* /app/
RUN shards install
COPY . /app
RUN rm -rf /app/node_module
RUN groupadd -g 999 panel && \
    useradd -r -u 999 -g panel -d /app -s /bin/bash panel
RUN chown -R panel:panel /app
CMD amber watch
