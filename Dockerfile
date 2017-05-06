FROM php

# Add common extensions.
RUN apt-get update && apt-get -y install sqlite3 libsqlite3-dev libpng12-dev

# Install required php exstensions.
RUN docker-php-ext-install gd zip

# Install Drush.
RUN curl -L --output /usr/local/bin/drush https://github.com/drush-ops/drush/releases/download/8.1.11/drush.phar && chmod +x /usr/local/bin/drush

# Download Drupal.
RUN drush dl drupal-8 --destination=/root --drupal-project-rename=drupal

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

RUN composer require -d=/root/drupal --prefer-dist drush/drush

RUN /root/drupal/vendor/bin/drush si -y -r /root/drupal --db-url=sqlite://sites/default/files/db.sqlite --site-name=drupal-repl

ENTRYPOINT ["/root/drupal/vendor/bin/drush", "-r", "/root/drupal", "php"]
