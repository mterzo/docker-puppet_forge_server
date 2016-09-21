#
# Dockerfile
#
# Author: Matteo Cerutti <matteo.cerutti@hotmail.co.uk>
#

FROM ruby:2.3.1-alpine
MAINTAINER Matteo Cerutti <matteo.cerutti@hotmail.co.uk>

ENV PUPPET_FORGE_SERVER_BASEDIR /srv/puppet-forge-server
ENV FORGE_SERVER_MODULEDIR /srv/puppet-forge-server/modules
ENV PUPPET_FORGE_SERVER_VERSION 1.9.0
ENV PUPPET_FORGE_SERVER_PORT 8080

ENV PUPPET_FORGE_DEPS \
    gcc         \
    make        \
    libc-dev    \
    ruby-dev

RUN apk add --no-cache $PUPPET_FORGE_DEPS            \
    && gem install --no-document puppet-forge-server \
        -v $PUPPET_FORGE_SERVER_VERSION              \
    && gem install --no-document puma                \
    && apk del $PUPPET_FORGE_DEPS

# Needed to fetch dependencies
RUN mkdir -p $PUPPET_FORGE_SERVER_BASEDIR

EXPOSE $PUPPET_FORGE_SERVER_PORT

ADD run.sh /run.sh

WORKDIR $PUPPET_FORGE_SERVER_BASEDIR
ENTRYPOINT ["/run.sh"]
