FROM php

RUN apt-get update && apt-get -y install sqlite3 libsqlite3-dev libpng-dev libzip-dev

RUN docker-php-ext-install gd zip

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

RUN curl --output /tmp/drupal.tar.gz https://ftp.drupal.org/files/projects/drupal-8.7.6.tar.gz && \
    tar -xf /tmp/drupal.tar.gz && \
    mv drupal-8.7.6 /root/drupal

RUN rm /root/drupal/composer.lock && \
    composer require --working-dir=/root/drupal --no-update drush/drush && \
    composer --working-dir=/root/drupal install --no-dev

RUN php /root/drupal/core/scripts/drupal install standard

ENTRYPOINT ["/root/drupal/vendor/bin/drush", "-r", "/root/drupal", "php"]
