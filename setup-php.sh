#!/usr/bin/env bash
apt-get -y install php5-fpm
service php5-fpm stop
sed -i 's/start-stop-daemon --start/ip netns exec nginx start-stop-daemon --start/' /etc/init.d/php5-fpm
sed -i 's/^;chroot.*/chroot = \/home\/nginx/' /etc/php5/fpm/pool.d/www.conf
sed -i 's/^listen = .*/listen = 9000/' /etc/php5/fpm/pool.d/www.conf
sed -i 's/^;cgi.fix_pathinfo.*/cgi.fix_pathinfo = 0/' /etc/php5/fpm/pool.d/www.conf
