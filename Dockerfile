FROM registry.cn-hangzhou.aliyuncs.com/jiyis/base:1.0.0
MAINTAINER gary <dongpengfei@patsnap.com>

RUN \
    yum -y install which sudo gcc autoconf libjpeg libpng freetype libxml2 zlib glibc glib2 bzip2 curl e2fsprogs openssl make cmake gd gd2 libmcrypt readline libxslt  libmemcached pcre-devel ImageMagick ImageMagick-devel openssl-devel glib2-devel supervisor && \
    yum clean all

RUN \
    rpm -ivh http://47.52.147.138/nginx-1.12.1-2.el7.x86_64.rpm && \
    rpm -ivh http://47.52.147.138/php-5.6.33-6.el7.x86_64.rpm

COPY conf/supervisor/ /etc/supervisord.d/

COPY conf/php/ /usr/local/php/etc/

COPY conf/nginx/ /usr/local/nginx/conf/

COPY conf/init/ /config/init/

EXPOSE 80
