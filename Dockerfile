FROM php

# Declare arguments.
ARG DRUSH_VERSION
ARG DRUPAL_VERSION

# Add common extensions.
RUN apt-get update && \
    apt-get -y install sqlite3 && \
    apt-get -y install libsqlite3-dev && \
    apt-get -y install libpng12-dev

# Install required php exstensions.
RUN docker-php-ext-install pdo_sqlite gd

# Install Drush.
RUN curl -L --output /usr/local/bin/drush https://github.com/drush-ops/drush/releases/download/$DRUSH_VERSION/drush.phar && chmod +x /usr/local/bin/drush

# Install Drupal.
RUN drush dl drupal-$DRUPAL_VERSION --destination=/root --drupal-project-rename=drupal && \
    drush si -y -r /root/drupal --db-url=sqlite://sites/default/files/db.sqlite --site-name=drupal-repl

ENTRYPOINT ["drush", "-r", "/root/drupal", "php"]
