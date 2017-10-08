.PHONY: clean build test

.DEFAULT_GOAL:=build

clean:
    sudo docker rmi influxdb:snapshot

build:
    sudo docker build -t influxdb:snapshot .
    sudo docker tag -t influxdb:snapshot influxdb:prod

test:
    echo 'testing'
