.PHONY: clean init build test save publish build_only publish_only

.DEFAULT_GOAL:=build

CONTAINER_NAME:=influxdb
ARTIFACT_NAME:=influxdb-1.3.2_linux_armhf.tar.gz

clean:
	sudo docker rmi ${CONTAINER_NAME}\:snapshot | true

init:
# Download artifact if the file does not exist locally
# TODO: Be sure that a local proxy is present for this action - remove IF logic to always pull, since proxy will be very fast

	test -e ${ARTIFACT_NAME} && \
		echo '${ARTIFACT_NAME} already present' || \
		wget https://dl.influxdata.com/influxdb/releases/${ARTIFACT_NAME} \

# Check for the latest version of this image and pull if available
	docker pull docker.io/arm32v7/busybox:latest

build: clean init build_only

build_only:
	sudo docker build -t ${CONTAINER_NAME}\:snapshot .
# sudo docker tag -t ${CONTAINER_NAME}\:snapshot ${CONTAINER_NAME}\:prod

save:
	sudo docker save -o influxdb_snapshot.tar influxdb:snapshot
	sudo chown `whoami` influxdb_snapshot.tar

publish: save publish_only

publish_only:
# scp telegraf_snapshot.tar nickv@nighthawk.local:~/.
	ssh nickv@nighthawk.local -C '/usr/bin/docker load -i ./influxdb_snapshot.tar'

test:
	echo 'testing'
