## Based on:
## https://github.com/doublerebel/nginx-chroot

NGINX_JAIL=/home/nginx

echo "Creating chroot jail for nginx..."

mkdir -p ${NGINX_JAIL}

echo "Creating basic filesystem structure..."
mkdir -p ${NGINX_JAIL}/{etc,lib,dev,usr,usr/sbin,usr/local,tmp,var,var/tmp}
chmod 1777 ${NGINX_JAIL}/tmp
chmod 1777 ${NGINX_JAIL}/var/tmp

echo "Creating required devices..."
/bin/mknod -m 0666 ${NGINX_JAIL}/dev/null c 1 3
/bin/mknod -m 0666 ${NGINX_JAIL}/dev/random c 1 8
/bin/mknod -m 0444 ${NGINX_JAIL}/dev/urandom c 1 9

echo "Copying nginx files..."
/bin/cp -farv /usr/local/nginx ${NGINX_JAIL}/usr/local/
/bin/cp -fv /lib/x86_64-linux-gnu/{libc.so*,libpthread*,ld-linux-x86-64*,libnss_compat*,libnsl*,libnss_nis*,libnss_files*} ${NGINX_JAIL}/lib
/bin/cp -fv nginx.conf /home/nginx/usr/local/nginx/conf

echo "Copying etc..."
grep nogroup /etc/group > ${NGINX_JAIL}/etc/group
grep nobody /etc/passwd > ${NGINX_JAIL}/etc/passwd
grep nobody /etc/shadow > ${NGINX_JAIL}/etc/shadow
grep nobody /etc/gshadow > ${NGINX_JAIL}/etc/gshadow
cp -fv /etc/{services,adjtime,shells,hosts.deny,localtime,nsswitch.conf,protocols,ld.so.cache,ld.so.conf,host.conf} ${NGINX_JAIL}/etc

echo "Testing chrooted nginx..."
/usr/sbin/chroot /home/nginx /usr/local/nginx/sbin/nginx -t

exit 0
