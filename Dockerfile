FROM registry.cn-hangzhou.aliyuncs.com/jiyis/base:1.0.0
MAINTAINER gary <dongpengfei@patsnap.com>

RUN \
    yum -y install which sudo gcc autoconf libjpeg libpng freetype libxml2 zlib glibc glib2 bzip2 curl e2fsprogs openssl make  cmake gd gd2 libmcrypt readline libxslt  libmemcached  freetds freetds-devel openldap openldap-devel ImageMagick ImageMagick-devel supervisor && \
    yum clean all

RUN \
    rpm -ivh http://192.168.3.60/rpm/7/oracle-instantclient-basic-10.2.0.5-1.x86_64.rpm && \
    rpm -ivh http://192.168.3.60/rpm/7/oracle-instantclient-devel-10.2.0.5-1.x86_64.rpm && \
    rpm -ivh http://192.168.3.60/rpm/7/nginx-1.12.1-2.el7.x86_64.rpm && \
    rpm -ivh http://192.168.3.60/rpm/7/php-7.1.8-3.el7.x86_64.rpm && \
    rpm -ivh http://192.168.3.60/rpm/7/jre-8u111-linux-x64.rpm

COPY conf/supervisor/ /etc/supervisord.d/

COPY conf/php/ /usr/local/php/etc/

COPY conf/nginx/ /usr/local/nginx/conf/

COPY conf/init/ /config/init/

EXPOSE 80
