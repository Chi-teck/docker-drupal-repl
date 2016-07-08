FROM php

# Declare arguments.
ARG DRUSH_VERSION=8.1.2
ARG DRUPAL_VERSION=8.2.x

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

# Disable Cron.
RUN ["/bin/bash", "-c", "if [[ ${DRUPAL_VERSION:0:1} = 8 ]]; then drush -r /root/drupal -y config-set automated_cron.settings interval 0; fi;"]

ENTRYPOINT ["drush", "-r", "/root/drupal", "php"]
