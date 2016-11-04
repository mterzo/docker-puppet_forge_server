#!/bin/sh
#
# run.sh
#
# Original Author: Matteo Cerutti <matteo.cerutti@hotmail.co.uk>
# Author: Mike Terzo <mike@terzo.org>

PUPPET_FORGE_SERVER_PORT=${PUPPET_FORGE_SERVER_PORT:-8080}

mkdir -p ${PUPPET_FORGE_SERVER_BASEDIR}
mkdir -p ${FORGE_SERVER_MODULEDIR}
mkdir -p ${FORGE_SERVER_CACHEDIR}
mkdir -p ${FORGE_SERVER_LOGDIR}

echo "Starting puppet-forge-server"
puppet-forge-server --port $PUPPET_FORGE_SERVER_PORT \
    -m ${FORGE_SERVER_MODULEDIR} \
    -x ${FORGE_CACHE_SERVER} \
    --log-dir ${FORGE_SERVER_LOGDIR} \
    --cache-basedir $PUPPET_FORGE_SERVER_CACHEDIR \
    --webui-root /app/webui
    $PUPPET_EXTRA_ARGS
