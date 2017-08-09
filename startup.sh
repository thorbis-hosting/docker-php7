#!/bin/sh

/usr/local/bin/parseConfig /app/config.inc.php /etc/phpmyadmin/config.inc.php

/usr/sbin/httpd -DFOREGROUND
