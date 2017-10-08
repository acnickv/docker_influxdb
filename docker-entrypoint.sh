#!/bin/sh

exec \
    /influxdb/usr/bin/influxd \
    run \
    -config /influxdb/influxdb.conf \
    -pidfile /var/run/influxdb.pid

