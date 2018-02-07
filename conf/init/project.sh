#!/bin/bash

BASEDIR='/bigdisk/docs/php'
HOME_DIR=$(pwd)

#创建日志目录
mkdir -p /opt/logs/supervisord

#set laravel crontab
#crontab -r
#line="* * * * * php /data/inno/miscroservice/artisan schedule:run >> /dev/null 2>&1"
#(crontab -u root -l; echo "$line" ) | crontab -u root -

# declare -A ENV
# while read line; do
#   name=`echo $line|awk -F '=' '{print $1}'`
#   value=`echo $line|awk -F '=' '{print $2}'`
#   [ -n "$name" ] && ENV["$name"]=$value
# done

#replace placeholder by env
sed -i \
        -e "s|{{NG_PC_PORT}}|${NG_PC_PORT}|g" \
        -e "s|{{NG_PC_DOMAIN}}|${NG_PC_DOMAIN}|g" \
        -e "s|{{NG_PC_PATH}}|${NG_PC_PATH}|g" \
        /usr/local/nginx/conf/conf.d/pc.conf

sed -i \
        -e "s|{{NG_MOBILE_PORT}}|${NG_MOBILE_PORT}|g" \
        -e "s|{{NG_MOBILE_DOMAIN}}|${NG_MOBILE_DOMAIN}|g" \
        -e "s|{{NG_MOBILE_PATH}}|${NG_MOBILE_PATH}|g" \
        /usr/local/nginx/conf/conf.d/mobile.conf


#fix locale bug
tee /etc/environment <<- 'EOF'
LANG=en_US.utf-8
LC_ALL=
EOF
source /etc/environment
localedef -v -c -i en_US -f UTF-8 en_US.UTF-8

chown -R www.www ${BASEDIR}
ls -ld /opt/logs/nginx > /dev/null 2>&1 || (mkdir -p /opt/logs/nginx && chown www.www /opt/logs/nginx)
ls -ld /opt/logs/php > /dev/null 2>&1 || (mkdir -p /opt/logs/php && chown www.www /opt/logs/php)

#set php env
echo 'PATH=/usr/local/php/sbin:$PATH'>> /etc/profile
echo 'export PATH'>> /etc/profile
source /etc/profile
# ln -s /usr/local/php/bin/php /usr/bin/php

rm -f /usr/local/nginx/conf/conf.d/service.conf
