#
# Dockerfile
#
# Author: Matteo Cerutti <matteo.cerutti@hotmail.co.uk>
#

FROM ruby:2.3.1-alpine
MAINTAINER Matteo Cerutti <matteo.cerutti@hotmail.co.uk>

ENV PUPPET_FORGE_SERVER_BASEDIR /srv/puppet-forge-server
ENV PUPPET_FORGE_SERVER_VERSION 1.9.0

RUN apk add --no-cache \
      gcc \
      make \
      libc-dev \
      ruby-dev

# Needed to fetch dependencies
RUN mkdir -p $PUPPET_FORGE_SERVER_BASEDIR
RUN gem install puppet-forge-server -v $PUPPET_FORGE_SERVER_VERSION
RUN gem install puma

ADD run.sh /run.sh

WORKDIR $PUPPET_FORGE_SERVER_BASEDIR
ENTRYPOINT ["/run.sh"]
