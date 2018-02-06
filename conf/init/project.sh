#!/bin/bash

#创建日志目录
mkdir -p /opt/logs/supervisord


#set php env
ln -s /usr/local/php/bin/php /usr/bin/php

#set laravel crontab
#crontab -r
#line="* * * * * php /data/inno/miscroservice/artisan schedule:run >> /dev/null 2>&1"
#(crontab -u root -l; echo "$line" ) | crontab -u root -

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
