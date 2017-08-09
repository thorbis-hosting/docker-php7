FROM alpine:latest
MAINTAINER jckimble <jckimble@thorbis.com>

RUN apk update && apk upgrade && apk add apache2 apache2-utils php7 php7-apache2 php7-openssl php7-mbstring php7-session php7-mysqli php7-xml php7-zlib php7-bz2 php7-zip php7-intl php7-opcache php7-ctype php7-mcrypt php7-json php7-gd php7-curl php7-mysqlnd php7-sqlite3 php7-phar && ln -s /usr/bin/php7 /usr/bin/php && rm -rf /var/cache/apk/* && mkdir -p /usr/share/webapps/ && wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-4.5.0.2-all-languages.tar.gz && tar zxvf phpMyAdmin-4.5.0.2-all-languages.tar.gz -C /usr/share/webapps && rm phpMyAdmin-4.5.0.2-all-languages.tar.gz && mv /usr/share/webapps/phpMyAdmin-4.5.0.2-all-languages /usr/share/webapps/phpmyadmin && mkdir -p /run/apache2 && mkdir -p /etc/phpmyadmin

COPY config.inc.php /app/
COPY phpmyadmin.conf /etc/apache2/conf.d/
COPY basedir.ini /etc/php7/conf.d/02_basedir.ini
ADD https://github.com/thorbis-hosting/ParseConfig/releases/download/v0.1/ParseConfig /usr/local/bin/
COPY startup.sh /startup.sh

RUN chmod +x /startup.sh
RUN sed -i 's#AllowOverride None#AllowOverride All#' /etc/apache2/httpd.conf
RUN sed -i 's#\#LoadModule rewrite_module modules/mod_rewrite.so#LoadModule rewrite_module modules/mod_rewrite.so#' /etc/apache2/httpd.conf

EXPOSE 80
VOLUME ["/var/www/localhost/htdocs"]
CMD ["/startup.sh"]
