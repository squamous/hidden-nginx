#!/usr/bin/env bash

pkill nginx
service php5-fpm stop
ip netns exec nginx ip link set veth1 down
ip netns exec nginx ip link del veth1
#veth0 paired to veth1, deleted automatically
ip netns del nginx
