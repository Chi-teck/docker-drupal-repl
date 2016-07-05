# Drupal REPL docker container

A Docker container to run PHP REPL ([PSYSH](http://psysh.org/)) against a sample Drupal site.

## Usage

Latest Drupal version
```bash
docker run --rm -it attr/drupal-repl
```

Stable Drupal 8 version
```bash
docker run --rm -it attr/drupal-repl:8
```

Stable Drupal 7 version
```bash
docker run --rm -it attr/drupal-repl:7
```

You may consider creating bash alias to help reduce typing.
```bash
echo 'alias drupal-repl="docker run --rm -it attr/drupal-repl"' >> ~/.bashrc
```

## Development
```bash
git clone https://github.com/Chi-teck/docker-drupal-repl
cd docker-drupal-repl
docker build --build-arg DRUSH_VERSION=8.1.2 --build-arg DRUPAL_VERSION=8 -t my/drupal-repl:8 .
```

## Notes
Use CTRL + D to exit the REPL.
