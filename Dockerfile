FROM debian:jessie
MAINTAINER Jimmy Cuadra <jimmy@jimmycuadra.com>

ENV REDIS_MAJOR_MINOR_VERSION 3.0
ENV REDIS_VERSION 3.0.1
ENV REDIS_TARBALL_SHA1 fe1d06599042bfe6a0e738542f302ce9533dde88

RUN apt-get -q update && \
  DEBIAN_FRONTEND=noninteractive apt-get -qy --no-install-recommends install \
    build-essential \
    curl && \
  curl -O http://download.redis.io/releases/redis-$REDIS_VERSION.tar.gz && \
  [ $(shasum redis-$REDIS_VERSION.tar.gz | awk '{ print $1 }') = $REDIS_TARBALL_SHA1 ] && \
  tar zxf redis-$REDIS_VERSION.tar.gz && \
  cd redis-$REDIS_VERSION && \
  make -j$(nproc) && \
  cd src && \
  cp \
    redis-benchmark \
    redis-check-aof \
    redis-check-dump \
    redis-cli \
    redis-sentinel \
    redis-server \
    /usr/local/bin && \
  cd ../.. && \
  rm -rf redis-$REDIS_VERSION redis-$REDIS_VERSION.tar.gz /tmp/* /var/tmp/* && \
  apt-get -qy purge build-essential curl && \
  apt-get -qy clean autoclean autoremove && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY redis.conf /etc/redis.conf
VOLUME /var/lib/redis
CMD ["/usr/local/bin/redis-server", "/etc/redis.conf"]
EXPOSE 6379
