#!/bin/sh

PHP_CONF_PATH=/usr/local/etc

# Display PHP error's or not
if [[ "$ERRORS" != "1" ]] ; then
  sed -i -e "s/error_reporting =.*=/error_reporting = E_ALL/g" $PHP_CONF_PATH/php.ini
  sed -i -e "s/display_errors =.*/display_errors = stdout/g" $PHP_CONF_PATH/php.ini
fi

# Disable opcache?
# if [[ -v NO_OPCACHE ]]; then
#     sed -i -e "s/zend_extension=opcache.so/;zend_extension=opcache.so/g" /etc/php.d/zend-opcache.ini
# fi

/usr/bin/supervisord -n -c /etc/supervisord.conf
