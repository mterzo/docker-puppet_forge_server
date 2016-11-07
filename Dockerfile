#
# Dockerfile
#
# Original Author: Matteo Cerutti <matteo.cerutti@hotmail.co.uk>
# Author: Mike Terzo <mike@terzo.org>
#

FROM ruby:2.1-alpine
MAINTAINER Mike Terzo <mike@terzo.org>

ENV PUPPET_FORGE_SERVER_BASEDIR /forge
ENV FORGE_SERVER_MODULEDIR /forge/modules
ENV FORGE_SERVER_CACHEDIR /forge/cache
ENV FORGE_SERVER_LOGDIR /forge/logs
ENV FORGE_CACHE_SERVER https://forgeapi.puppetlabs.com
ENV PUPPET_FORGE_SERVER_VERSION 1.9.0
ENV PUPPET_FORGE_SERVER_PORT 80

ENV PUPPET_FORGE_DEPS \
    gcc         \
    make        \
    libc-dev

RUN apk add --no-cache $PUPPET_FORGE_DEPS            \
    && gem install --no-document puppet-forge-server \
        -v $PUPPET_FORGE_SERVER_VERSION              \
    && gem install --no-document puma                \
    && apk del $PUPPET_FORGE_DEPS

EXPOSE $PUPPET_FORGE_SERVER_PORT

ADD run.sh /run.sh
ADD webui /app/webui

ENTRYPOINT ["/run.sh"]
