# ----------------------------------
# Pelican Panel Dockerfile
# ----------------------------------

FROM        codeberg.org/forgejo/forgejo:15

LABEL       org.opencontainers.image.authors=“lorcster222@gmail.com”

RUN         apk update && apk add tini

## Setup user and working directory
# RUN         adduser -D -h /home/container -s /bin/bash container
RUN         adduser -D -h /data -s /bin/bash container
USER        container
# ENV         USER=container HOME=/home/container
ENV         USER=container HOME=/data

# WORKDIR     /home/container
WORKDIR     /data

STOPSIGNAL SIGINT

COPY        --chown=container:container ./entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT    ["/sbin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]
