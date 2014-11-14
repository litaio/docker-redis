# docker-redis

This repository contains the Dockerfile for Lita.io's public Redis image: [litaio/redis](https://registry.hub.docker.com/u/litaio/redis/)

## Configuration

The container provides a very minimal Redis configuration by default. It simply sets the data directory to a volume at /var/lib/redis and turns on the "noeviction" mode to prevent keys from being automatically removed when memory is full. To provide your own configuration file, mount a volume from the host directory containing the configuration file.

## Usage

Run with default configuration:

``` bash
docker run litaio/redis
```

Run with a custom configuration file, assuming `/etc/redis` is a directory containing a `redis.conf`:

``` bash
docker run -v /etc/redis:/redis litaio/redis /usr/local/bin/redis-server /redis/redis.conf
```

## License

[MIT](http://opensource.org/licenses/MIT)
