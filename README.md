# docker-redis

This repository contains the Dockerfile for Lita.io's public Redis image: [litaio/redis](https://registry.hub.docker.com/u/litaio/redis/)

## Configuration

The container provides a very minimal Redis configuration by default. It simply sets the data directory to a volume at /var/lib/redis and turns on the "noeviction" mode to prevent keys from being automatically removed when memory is full. To provide your own configuration file, mount a volume from the host directory containing the configuration file.

## Usage

For default settings, run:

``` bash
docker run --name redis litaio/redis
```

This will require that other containers that need to access redis do so using Docker's linking feature. Use the `-p` or `-P` flags if you need to expose Redis on a host port.

It's recommended to run the container with a host volume for persistent data storage:

``` bash
docker run -v /path/to/redis/data:/var/lib/redis litaio/redis
```

To run with a custom configuration file:

``` bash
docker run -v /etc/redis.conf:/redis.conf litaio/redis /usr/local/bin/redis-server /redis.conf
```

## License

[MIT](http://opensource.org/licenses/MIT)
