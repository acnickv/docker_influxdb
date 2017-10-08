FROM docker.io/arm32v7/busybox:latest

LABEL maintainer="Nick V<dcnickv@gmail.com>"

LABEL component="influxdb"
LABEL component_version="1.3.2-1"

COPY influxdb-1.3.2_linux_armhf.tar.gz /
COPY influxdb.conf /
COPY docker-entrypoint.sh /

RUN tar xzf /influxdb-1.3.2_linux_armhf.tar.gz -C / && \
    mv influxdb-1.3.2-1 influxdb && \
    mv /influxdb.conf /influxdb/ && \
    mkdir -p /data && \
    adduser -u 900 -D -S influxdb && \
    chown -R influxdb: /influxdb && \
    chown -R influxdb: /data && \
    chown -R influxdb: /docker-entrypoint.sh && \
    chmod 0500 /docker-entrypoint.sh

EXPOSE 8086

VOLUME /data

WORKDIR /influxdb

USER influxdb

ENTRYPOINT ["/docker-entrypoint.sh"]
# ENTRYPOINT ["/influxdb/usr/bin/influxd"]
# CMD ["run","-config","/influxdb/influxdb.conf","-pidfile","/var/run/influxdb.pid"]
