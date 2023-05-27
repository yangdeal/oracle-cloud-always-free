#!/bin/sh

apk add nfs-utils openrc

mkdir -p /run/openrc
touch /run/openrc/softlevel

rc-update add nfs
rc-service nfs start
while true; do sleep 1; done
