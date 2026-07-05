# ----------------------------------
# Pelican Panel Dockerfile
# ----------------------------------

FROM        codeberg.org/forgejo/forgejo:15-rootless

LABEL       org.opencontainers.image.authors=“lorcster222@gmail.com”

RUN         apk update && apk add tini

## Setup user and working directory
RUN         adduser -D -h /home/container -s /bin/bash container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL SIGINT

COPY        --chown=container:container ./entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT    ["/sbin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]
