#!/usr/bin/env bash

apt-get -y install tor git
service tor stop
git clone https://github.com/sinner-/tor-chroot
cd tor-chroot
make install
tor-chroot-update.sh
cd -
cp -fv torrc /home/tor-chroot/etc/tor/torrc
