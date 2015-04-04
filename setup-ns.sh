#!/usr/bin/env bash
ip link add veth0 type veth peer name veth1
ip link set veth0 up
ip addr add 192.168.254.253/24 broadcast 192.168.254.255 dev veth0
ip netns add nginx
ip netns exec nginx ip link set lo up
ip link set veth1 netns nginx
ip netns exec nginx ip link set veth1 up
ip netns exec nginx ip addr add 192.168.254.254/24 broadcast 192.168.254.255 dev veth1
