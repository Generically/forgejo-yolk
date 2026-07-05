# ----------------------------------
# Pelican Panel Dockerfile
# ----------------------------------

FROM        codeberg.org/forgejo/forgejo:15-rootless

LABEL       org.opencontainers.image.authors=“lorcster222@gmail.com”

## Setup user and working directory
# RUN         adduser -D -h /home/container -s /bin/bash container
# USER        container
# ENV         USER=container HOME=/home/container

WORKDIR     /home/container

STOPSIGNAL SIGINT

COPY        ./entrypoint.sh /home/container/entrypoint.sh
COPY        ./tini /home/container/tini

# COPY        --chown=container:container ./app.ini /home/container/custom/conf/app.ini
# RUN         chmod +x /entrypoint.sh
# RUN         chmod +x /tini.sh

ENTRYPOINT    ["/sbin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]
