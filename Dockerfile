# ----------------------------------
# Pelican Panel Dockerfile
# ----------------------------------

FROM        codeberg.org/forgejo/forgejo:15

LABEL       org.opencontainers.image.authors=“lorcster222@gmail.com”

RUN         apk update && apk add --no-cache tini

## Setup user and working directory
RUN         adduser -D -h /home/container -s /bin/bash container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL SIGINT

COPY        --chown=container:container ./entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT    ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]
